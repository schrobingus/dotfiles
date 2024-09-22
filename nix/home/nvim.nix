# TODO: make a separate flake / repository for my nixvim configuration, then reference it in this home manager config

{ inputs, pkgs, ... }: 
let
  mkLuaFile = file: ''
    lua << EOF
      dofile("${file}")
    EOF
  '';
  mkLua = lua: ''
    lua << EOF
      ${lua}
    EOF
  '';
in
  {
    imports = [
      inputs.nixvim.homeManagerModules.nixvim
    ];

    programs.nixvim = {
      enable = true;

      globals.mapleader = " ";

      # NOTE: extraConfigLua, extraConfigLuaPre and extraConfigLuaPost are both valid options.

      extraPlugins = with pkgs.vimPlugins; [
        jellybeans-vim  # Jellybeans theme. # TODO: switch to base16

        true-zen-nvim # "Zen mode" for Vim, hides surrounding content for focus.
        vim-nix # Nix functionality and integration.

        # vim-swap  # Quick delimiter swapping inputs.  # NOTE: i don't think i need this
        vim-table-mode  # Allows one to make Markdown formatted tables with ease.

        firenvim # Embeds Neovim within web browser text areas.

        { # Integration for the ZK plain text notes tool.
          plugin = zk-nvim;
          config = mkLua ''
            require('zk').setup()
          '';
        }

        { # Jumps to a char pair quickly. Similar to Snipe, Sneak, Seek, etc.
          plugin = leap-nvim;
          config = mkLua ''
            require('leap').create_default_mappings()
          '';
        }

        { # Tools for Dart and Flutter.
          plugin = flutter-tools-nvim;
          config = mkLua ''
            require("flutter-tools").setup {}
          '';
        }
      ];

      plugins = {
        # Treesitter parsing for Neovim.
        treesitter = {
          enable = true;

          nixGrammars = true;
          grammarPackages = pkgs.vimPlugins.nvim-treesitter.allGrammars;
          ensureInstalled = "all";

          indent = true;
          # folding = true;
          nixvimInjections = true;
        };

        # Language Server Protocol for Neovim.
        lsp = {
          enable = true;

          keymaps = {
            silent = true;

            lspBuf = {
              gd = "definition";
              gD = "references";
              gt = "type_definition";
              gi = "implementation";
            };
          };

          servers = {
            nil-ls.enable = true;                 # Nix
            lua-ls.enable = true;                 # Lua

            # bashls.enable = true;               # Bash
            clojure-lsp.enable = false;           # Clojure
            omnisharp.enable = false;             # C#
            cssls.enable = false;                 # CSS
            dartls.enable = false;                # Dart
            denols.enable = false;                # Deno
            gdscript.enable = false;              # GDScript
            html.enable = false;                  # HTML
            java-language-server.enable = false;  # Java
            jsonls.enable = true;                 # JSON
            julials.enable = false;               # Julia
            nimls.enable = false;                 # Nim
            pylsp.enable = true;                  # Python
            r-language-server.enable = false;     # R
            ruby-lsp.enable = false;              # Ruby
            # rust-analyzer.enable = false;       # Rust
            sourcekit.enable = true;              # Swift, C, C++, Obj-C, etc
            tsserver.enable = false;              # TypeScript
            typst-lsp.enable = false;             # Typst
            vala-ls.enable = false;               # Vala
            # zls.enable = false;                 # Zig
          };
        };

        mini.enable = true; # Library of lightweight useful plugins.

        # Simple statusline for Neovim.
        mini.modules.statusline = {
          use_icons = true;  # NOTE: might want to take a look at the icons module
          set_vim_settings = false;
        }; 

        # mini.modules.icons = {};  # Provides icons for mini.nvim. # FIXME: cooked in nixvim, either submit an issue or pr
        mini.modules.pairs = {};  # Automatically pairs delimiters.
        mini.modules.surround = {}; # Rapid delimiter navigation.

        # Previews referenced colors within the editor.
        nvim-colorizer = {
          enable = true;
          userDefaultOptions = {
            RGB      = true;
            RRGGBB   = true;
            RRGGBBAA = true;
            css_fn   = true;
            names    = false;
          };
        };

        smart-splits = {
          enable = true;
          settings = {
            ignored_events = [
              "BufEnter"
              "WinEnter"
            ];
            silent = true;
            # TODO: look into resize mode. in particular, make sure it works with wezterm
          };
        };

        # All of these are configured in extraConfigLua or do not need further configuration.
        fzf-lua.enable = true;  # FZF for Neovim, fills in the role of a fuzzy finder.
        gitsigns.enable = true; # Adds git signs to the gutter.
        indent-blankline.enable = true; # Whitespace / indent guides.
        multicursors.enable = true; # Functionality for multiple cursors at once.
        rainbow-delimiters.enable = true; # Distinguishes delimiter pairs with colors.
        trouble.enable = true;  # A diagnostics and quickfix list.
      };

      opts = {
        number = true;

        cursorline = true;
        wrap = true;
        linebreak = true;
        breakindent = false;
        list = false;

        ruler = true;
        showcmd = true;
        showmode = true;
        hlsearch = true;
        ignorecase = true;
        smartcase = true;
        cmdheight = 0;

        foldcolumn = "0";
        foldlevel = 99;
        foldlevelstart = -1;
        foldmethod = "expr";
        foldexpr = "nvim_treesitter#foldexpr()";
        foldenable = true;

        termguicolors = true;

        expandtab = true;
        tabstop = 2;
        softtabstop = 2;
        shiftwidth = 2;
        autoindent = true;
        cindent = true;
        smartindent = true;
        smarttab = true;

        laststatus = 3;

        scrolloff = 6;

        backspace = "indent,eol,start";

        guifont = "SF Mono:h15";
      };

      # TODO: make the rainbow colors correspond to term colors
      /*
        TODO: apply some settings to markdown specifically, such as:
        - `breakindent`
        - `nocursorline`
        - `nonumber`
        - `conceallevel=3`
        - disable indent-blankline entirely
      */
      extraConfigLua = /* lua */ ''
        local highlight = {
          "RainbowRed",
          "RainbowGreen",
          "RainbowYellow",
          "RainbowBlue",
          "RainbowViolet",
        }

        local hooks = require "ibl.hooks"
        hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
          vim.api.nvim_set_hl(0, "RainbowRed", { fg = "#FF9EA0" })
          vim.api.nvim_set_hl(0, "RainbowGreen", { fg = "#AED69F" })
          vim.api.nvim_set_hl(0, "RainbowYellow", { fg = "#FFDA97" })
          vim.api.nvim_set_hl(0, "RainbowBlue", { fg = "#A0D0EF" })
          vim.api.nvim_set_hl(0, "RainbowViolet", { fg = "#F4CEF5" })
          vim.api.nvim_set_hl(0, "RainbowCyan", { fg = "#00ADA1" })
        end)

        vim.g.rainbow_delimiters = { highlight = highlight }
        -- TODO: scope acts specifically with curlies and nothing else, fix that
        -- TODO: scope underlines statement being used, which i'm not a big fan of. disable that
        require("ibl").setup {
          indent = { char = "▏" },
          scope = {
            show_start = true,
            show_end = true,
            highlight = highlight
          } 
        }

        hooks.register(hooks.type.SCOPE_HIGHLIGHT, hooks.builtin.scope_highlight_from_extmark)

        require("fzf-lua").register_ui_select()

        if vim.g.started_by_firenvim then
          vim.api.nvim_create_autocmd({'TextChanged', 'TextChangedI'}, {
            callback = function(e)
              if vim.g.timer_started == true then
                return
              end
              vim.g.timer_started = true
              vim.fn.timer_start(10000, function()
                vim.g.timer_started = false
                vim.cmd('silent write')
              end)
            end
          })
        end

        vim.g.firenvim_config = {
          localSettings = {
            [".*"] = {
              priority = 0,
              cmdline  = "neovim",
              content  = "text",
              selector = "textarea",
              takeover = "always"
            },

            -- Every backslash in the URL regular expressions must have
            -- double backslashes due to the way Lua handles strings.
            ["https?:\\/\\/(?:www\\.)?google\\.com\\/.*"] = {
              priority = 1,
              takeover = "never"
            },
            ["https?:\\/\\/(?:www\\.)?discord\\.com\\/.*"] = {
              priority = 1,
              takeover = "never"
            },
            ["https?:\\/\\/(?:www\\.)?chatgpt\\.com\\/.*"] = {
              priority = 1,
              takeover = "never"
            },
            ["https?:\\/\\/(?:www\\.)?github\\.com\\/.*\\/blob\\/.*"] = {
              priority = 1,
              takeover = "never"
            }
          }
        }

        vim.cmd("highlight clear SignColumn")

        require('gitsigns').setup {
          signs = {
            add = { text = '+' },
            change = { text = '~' },
            delete = { text = '_' },
            topdelete = { text = '‾' },
            changedelete = { text = '~' },
          },
          on_attach = function(bufnr)
            vim.keymap.set('n', '[c', require('gitsigns').prev_hunk, { buffer = bufnr })
            vim.keymap.set('n', ']c', require('gitsigns').next_hunk, { buffer = bufnr })
          end,
        }
      '';

      colorscheme = "jellybeans";

      clipboard = {
        register = "unnamedplus";

        # providers.wl-copy.enable = true;
      };

      # TODO: add descriptions for each keymap
      keymaps = [
        # Activate the command line without <Shift>, therefore using `;`.
        {
          mode = [ "n" "x" ];
          key = ";";
          action = ":";
        }

        # Switch back to NORMAL from INSERT using `jj`.
        {
          mode = "i";
          key = "jj";
          action = "<Esc>";
        }

        # Enact the black hole register for deleting.
        {
          mode = [ "n" "x" ];
          key = "d";
          action = ''"_d'';
        }

        # Add blank line below or above in NORMAL mode.
        {
          mode = "n";
          key = "<Leader>o";
          action = "o<Esc>k";
          options = { noremap = true; silent = true; };
        }
        {
          mode = "n";
          key = "<Leader>O";
          action = "O<Esc>k";
          options = { noremap = true; silent = true; };
        }

        # Window switching in NORMAL mode.
        {
          mode = "n";
          key = "<C-h>";
          # action = "<C-w>h";
          action = "<cmd>lua require('smart-splits').move_cursor_left()<CR>";
          options = { noremap = true; silent = true; };
        }
        {
          mode = "n";
          key = "<C-j>";
          # action = "<C-w>j";
          action = "<cmd>lua require('smart-splits').move_cursor_down()<CR>";
          options = { noremap = true; silent = true; };
        }
        {
          mode = "n";
          key = "<C-k>";
          # action = "<C-w>k";
          action = "<cmd>lua require('smart-splits').move_cursor_up()<CR>";
          options = { noremap = true; silent = true; };
        }
        {
          mode = "n";
          key = "<C-l>";
          # action = "<C-w>l";
          action = "<cmd>lua require('smart-splits').move_cursor_right()<CR>";
          options = { noremap = true; silent = true; };
        }

        # Window resizing in NORMAL mode.
        {
          mode = "n";
          key = "<A-h>";
          action = "<cmd>lua require('smart-splits').resize_left()<CR>";
          options = { noremap = true; silent = true; };
        }
        {
          mode = "n";
          key = "<A-j>";
          action = "<cmd>lua require('smart-splits').resize_down()<CR>";
          options = { noremap = true; silent = true; };
        }
        {
          mode = "n";
          key = "<A-k>";
          action = "<cmd>lua require('smart-splits').resize_up()<CR>";
          options = { noremap = true; silent = true; };
        }
        {
          mode = "n";
          key = "<A-l>";
          action = "<cmd>lua require('smart-splits').resize_right()<CR>";
          options = { noremap = true; silent = true; };
        }

        # Cursor movement in INSERT mode.
        {
          mode = "i";
          key = "<C-h>";
          action = "<Left>";
          options = { noremap = true; silent = true; };
        }
        {
          mode = "i";
          key = "<C-j>";
          action = "<Down>";
          options = { noremap = true; silent = true; };
        }
        {
          mode = "i";
          key = "<C-k>";
          action = "<Up>";
          options = { noremap = true; silent = true; };
        }
        {
          mode = "i";
          key = "<C-l>";
          action = "<Right>";
          options = { noremap = true; silent = true; };
        }

        # Bindings for multicursors.
        {
          mode = [ "n" "v" ];
          key = "<Leader>m";
          action = "<cmd>MCstart<cr>";
          options = { noremap = true; silent = true; };
        }

        # Bindings for trouble.
        {
          mode = "n";
          key = "<Leader>xx";
          action = "<cmd>Trouble diagnostics toggle<cr>";
          options = { noremap = true; silent = true; };
        }
        {
          mode = "n";
          key = "<Leader>xX";
          action = "<cmd>Trouble diagnostics toggle filter.buf=0<cr>";
          options = { noremap = true; silent = true; };
        }
        {
          mode = "n";
          key = "<Leader>cs";
          action = "<cmd>Trouble symbols toggle focus=false<cr>";
          options = { noremap = true; silent = true; };
        }
        {
          mode = "n";
          key = "<Leader>cl";
          action = "<cmd>Trouble lsp toggle focus=false win.position=right<cr>";
          options = { noremap = true; silent = true; };
        }
        {
          mode = "n";
          key = "<Leader>xL";
          action = "<cmd>Trouble loclist toggle<cr>";
          options = { noremap = true; silent = true; };
        }
        {
          mode = "n";
          key = "<Leader>xQ";
          action = "<cmd>Trouble qflist toggle<cr>";
          options = { noremap = true; silent = true; };
        }
      ];
    };
  }
