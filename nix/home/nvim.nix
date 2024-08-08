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
        jellybeans-vim
        vim-dim

        true-zen-nvim
        vim-nix

        {
          plugin = leap-nvim;
          config = mkLua ''
            require('leap').create_default_mappings()
          '';
        }

        {
          plugin = nvim-surround;
          config = mkLua ''
            require("nvim-surround").setup()
          '';
        }
        {
          plugin = vim-swap;
          # TODO: add config
        }
      ];

      plugins = {
        treesitter = {
          enable = true;

          nixGrammars = true;
          grammarPackages = pkgs.vimPlugins.nvim-treesitter.allGrammars;
          ensureInstalled = "all";

          indent = true;
          # folding = true;
          nixvimInjections = true;
        };

        gitsigns = {
          enable = true;
        };

        nvim-autopairs = {
          enable = true;
          settings.map_c_h = false;
        };

        # Both of these are configured in extraConfigLua.
        indent-blankline.enable = true;
        rainbow-delimiters.enable = true;

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
      };

      # TODO: make the colors correspond to term colors
      extraConfigLua = ''
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
