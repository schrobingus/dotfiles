{ inputs, pkgs, ... }:

{
  imports = [
    inputs.nixvim.homeManagerModules.nixvim
  ];

  programs.nixvim = {
    enable = true;

    globals.mapleader = "<Space>";

    plugins.lazy = {
      enable = true;

      plugins = [
        { # Treesitter plugin for Neovim.
          # TODO: use nixpkgs for ts
          name = "nvim-treesitter";
          lazy = false;
          opts = {
            ensure_installed = "all";
            parser_install_dir = "$HOME/.config/nvim/treesitter";
            highlight = {
              enable = true;
              additional_vim_regex_highlighting = true;
            };
          };
          pkg = pkgs.vimUtils.buildVimPlugin {
            name = "nvim-treesitter";
            src = pkgs.fetchFromGitHub {
              owner = "nvim-treesitter";
              repo = "nvim-treesitter";
              rev = "2d5133f67429f82547ea5fad33a0b1e7d4f78a1c";
              hash = "sha256-mPNUg3jyu6TsswSl2WT13VHe7TmgNzXBFOpwSacVQ0Y=";
            };
          };
        }

        { # Git tools for buffers.
          # TODO: configure to make it not ugly
          name = "gitsigns";
          lazy = false;
          pkg = pkgs.vimPlugins.gitsigns-nvim;
        }

        { # Jellybeans colorscheme.
          name = "jellybeans";
          lazy = false;
          pkg = pkgs.vimPlugins.jellybeans-vim;
        }
        { # Dim colorscheme, terminal agnostic.
          name = "vim-dim";
          lazy = false;
          pkg = pkgs.vimPlugins.vim-dim;
        }

        { # Whitespace + indent guides.
          name = "indent-blankline";
          lazy = false;
          pkg = pkgs.vimPlugins.indent-blankline-nvim;
        }
        { # Rainbow delimiters, which are parenthesis, brackets, etc.
          name = "rainbow-delimiters";
          lazy = false;
          pkg = pkgs.vimPlugins.rainbow-delimiters-nvim;
        }
        { # Highlights color codes in text.
          name = "nvim-colorizer";
          lazy = false;
          pkg = pkgs.vimPlugins.nvim-colorizer-lua;
        }

        { # Smart pairing for delimiters.
          name = "nvim-autopairs";
          lazy = false;
          pkg = pkgs.vimPlugins.nvim-autopairs;
        }
        { # Rapid tools for quick motion involving delimiters.
          name = "nvim-surround";
          lazy = false;
          pkg = pkgs.vimPlugins.nvim-surround;
        }

        { # Two-char search for Neovim. Similar to seek, sneak, snipe, etc.
          name = "leap";
          lazy = false;
          pkg = pkgs.vimPlugins.leap-nvim;
        }

        { # Zen mode including Ataraxis and Focus modes.
          name = "true-zen";
          lazy = false;
          pkg = pkgs.vimPlugins.true-zen-nvim;
        }

        { # Vim tools for Nix.
          name = "vim-nix";
          ft = [ "nix" ];
          lazy = true;
          pkg = pkgs.vimPlugins.vim-nix;
        }

        # TODO: try out neorg or a plain text notes system
      ];
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

      # autoread = true;
      # lazyredraw = true;
      # showmatch = true;
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

    clipboard = {
      register = "unnamedplus";

      # providers.wl-copy.enable = true;
    };

    keymaps = [
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
    ];

    # colorscheme = "jellybeans";
    extraConfigLua = mkLua ''
      require("gitsigns").setup()

      vim.cmd("colorscheme jellybeans")

      require("ibl").setup({
        indent = {
          char = "›",
          --char = "▸";
        },
        scope = {
          show_start = false,
          show_end = false,
        },
      })
      --[[
      local hooks = require("ibl.hooks")
      hooks.register(hooks.type.WHITESPACE, hooks.builtin.hide_first_space_indent_level)
      hooks.register(hooks.type.WHITESPACE, hooks.builtin.hide_first_tab_indent_level)
      ]]--

      --[[
      local rainbow_delimiters = require 'rainbow-delimiters'
      vim.g.rainbow_delimiters = {
        highlight = {
          'RainbowDelimiterRed',
          'RainbowDelimiterYellow',
          'RainbowDelimiterBlue',
          'RainbowDelimiterOrange',
          'RainbowDelimiterGreen',
          'RainbowDelimiterViolet',
          'RainbowDelimiterCyan',
        },
      }
      ]]--

      require("colorizer").setup()

      require("nvim-autopairs").setup({
        map_c_h = false
      })

      require('leap').create_default_mappings()
    '';
  };
}
