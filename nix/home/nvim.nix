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

      globals.mapleader = "<Space>";

      # NOTE: extraConfigLua, extraConfigLuaPre and extraConfigLuaPost are both valid options.

      extraPlugins = with pkgs.vimPlugins; [
        jellybeans-vim  # Jellybeans theme.
        vim-dim # Terminal-gnostic theme.

        true-zen-nvim # "Zen mode" for Vim, hides surrounding content for focus.
        vim-nix # Nix functionality and integration.

        vim-swap  # Quick delimiter swapping inputs.

        firenvim # Embeds Neovim within web browser text areas.
        zk-nvim # Integration for the ZK plain text notes tool.

        { # Jumps to a char pair quickly. Similar to Snipe, Sneak, Seek, etc.
          plugin = leap-nvim;
          config = mkLua ''
            require('leap').create_default_mappings()
          '';
        }

        { # Rapid delimiter placement and navigation.
          plugin = nvim-surround;
          config = mkLua ''
            require("nvim-surround").setup()
          '';
        }
      ] ++ [
        # GPT prompt for Neovim.
        (pkgs.vimUtils.buildVimPlugin {
          name = "gp.nvim";
          src = pkgs.fetchFromGitHub {
            owner = "Robitx";
            repo = "gp.nvim";
            rev = "861ed5240214dc76b00edeaec15e71370a7a5046";
            hash = "sha256-2vjPoRiT26dftA0t4hdGedN6qZyIgQUjGMRF4IND/O4=";
          };
        })
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

        gitsigns.enable = true; # Adds git signs to the gutter.

        # Automatically pairs delimiters.
        nvim-autopairs = {
          enable = true;
          settings.map_c_h = false;
        };

        # All of these are configured in extraConfigLua.
        fzf-lua.enable = true;  # FZF for Neovim, fills in the role of a fuzzy finder.
        indent-blankline.enable = true; # Whitespace / indent guides.
        rainbow-delimiters.enable = true; # Distinguishes delimiter pairs with colors.

        # Previews referenced colors within the editor.
        nvim-colorizer = {
          enable = true;
          userDefaultOptions = {
            RGB      = true;
            RRGGBB   = true;
            names    = false; # Might enable for Flutter later on.
            RRGGBBAA = true;
            css_fn   = true;
          };
        };
      };

      opts = {
        number = true;

        wrap = true;
        linebreak = true;
        list = false;

        ruler = true;
        showcmd = true;
        showmode = true;
        hlsearch = true;
        ignorecase = true;
        smartcase = true;

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
        require("ibl").setup { 
          indent = { char = "›" },
          scope = {
            show_start = true,
            show_end = true,
            highlight = highlight
          } 
        }

        hooks.register(hooks.type.SCOPE_HIGHLIGHT, hooks.builtin.scope_highlight_from_extmark)

        require("fzf-lua").register_ui_select()

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
            }
          }
        }

        require("gp").setup {
          providers = {
            openai = {
              disable = true,
            },
            ollama = {
              disable = false,
			        endpoint = "http://localhost:11434/v1/chat/completions"
            }
          },
          agents = {  -- All of these agents are built off Ollama models.
            {
              name = "Chat-Ollama-Phi2-Orca",
              provider = "ollama",
              chat = true,
              command = true,
              model = {
                model = "dolphin-phi",
                temperature = 0.8,
                top_p = 0.9,
                min_p = 0.05
              },
              system_prompt = "You are a general AI assistant."
            },
            {
              name = "Chat-Ollama-Phi3",
              provider = "ollama",
              chat = true,
              command = true,
              model = {
                model = "phi3",
                temperature = 0.8,
                top_p = 0.9,
                min_p = 0.05
              },
              system_prompt = "You are a general AI assistant."
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

        # Window switching in NORMAL mode.
        {
          mode = "n";
          key = "<C-h>";
          action = "<C-w>h";
          options = { noremap = true; silent = true; };
        }
        {
          mode = "n";
          key = "<C-j>";
          action = "<C-w>j";
          options = { noremap = true; silent = true; };
        }
        {
          mode = "n";
          key = "<C-k>";
          action = "<C-w>k";
          options = { noremap = true; silent = true; };
        }
        {
          mode = "n";
          key = "<C-l>";
          action = "<C-w>l";
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

        # Bindings for vim-swap.
        {
          mode = "n";
          key = "g<";
          action = "<Plug>(swap-prev)";
          options = { noremap = true; silent = true; };
        }
        {
          mode = "n";
          key = "g>";
          action = "<Plug>(swap-next)";
          options = { noremap = true; silent = true; };
        }
        {
          mode = "n";
          key = "gs";
          action = "<Plug>(swap-interactive)";
          options = { noremap = true; silent = true; };
        }
        {
          mode = "x";
          key = "i";
          action = "<Plug>(swap-textobject-i)";
          options = { noremap = true; silent = true; };
        }
        {
          mode = "x";
          key = "a";
          action = "<Plug>(swap-textobject-a)";
          options = { noremap = true; silent = true; };
        }
      ];
    };
  }
