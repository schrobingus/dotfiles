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

        { # Jellybeans colorscheme.
          name = "jellybeans";
          lazy = false;
          pkg = pkgs.vimUtils.buildVimPlugin {
            name = "jellybeans.vim";
            src = pkgs.fetchFromGitHub {
              owner = "nanotech";
              repo = "jellybeans.vim";
              rev = "ef83bf4dc8b3eacffc97bf5c96ab2581b415c9fa";
              hash = "sha256-X+37Mlyt6+ZwfYlt4ZtdHPXDgcKtiXlUoUPZVb58w/8=";
            };
          };
        }
        { # Dim colorscheme, terminal agnostic.
          name = "vim-dim";
          lazy = false;
          pkg = pkgs.vimUtils.buildVimPlugin {
            name = "vim-dim";
            src = pkgs.fetchFromGitHub {
              owner = "jeffkreeftmeijer";
              repo = "vim-dim";
              rev = "8320a40f12cf89295afc4f13eb10159f29c43777";
              hash = "sha256-sDt3gvf+/8OQ0e0W6+IinONQZ9HiUKTbr+RZ2CfJ3FY=";
            };
          };
        }

        { # Whitespace + indent guides.
          name = "indent-blankline";
          lazy = false;
          pkg = pkgs.vimUtils.buildVimPlugin {
            name = "indent-blankline.nvim";
            src = pkgs.fetchFromGitHub {
              owner = "lukas-reineke";
              repo = "indent-blankline.nvim";
              rev = "65e20ab94a26d0e14acac5049b8641336819dfc7";
              hash = "sha256-PSsXBB2KOFPJJ1O8fpTvsVe2A0/wU6Ae9dN/UemraZM=";
            };
          };
        }
        { # Rainbow delimiters, which are parenthesis, brackets, etc.
          name = "rainbow-delimiters";
          lazy = false;
          pkg = pkgs.vimUtils.buildVimPlugin {
            name = "rainbow-delimiters.nvim";
            src = pkgs.fetchFromGitLab {
              owner = "HiPhish";
              repo = "rainbow-delimiters.nvim";
              rev = "a727bd368e70808125b7cf589328cc595faf3d5a";
              hash = "sha256-6MGMI6UrratXy2WduO+DFzPHURzd0101PSU21l/getU=";
            };
          };
        }
        { # Highlights color codes in text.
          name = "nvim-colorizer";
          lazy = false;
          pkg = pkgs.vimUtils.buildVimPlugin {
            name = "nvim-colorizer.lua";
            src = pkgs.fetchFromGitHub {
              owner = "norcalli";
              repo = "nvim-colorizer.lua";
              rev = "a065833f35a3a7cc3ef137ac88b5381da2ba302e";
              hash = "sha256-gjO89Sx335PqVgceM9DBfcVozNjovC8KML1OZCRNMGw=";
            };
          };
        }

        { # Smart pairing for delimiters.
          name = "nvim-autopairs";
          lazy = false;
          pkg = pkgs.vimUtils.buildVimPlugin {
            name = "nvim-autopairs";
            src = pkgs.fetchFromGitHub {
              owner = "windwp";
              repo = "nvim-autopairs";
              rev = "e38c5d837e755ce186ae51d2c48e1b387c4425c6";
              hash = "sha256-2+r2SkCtLqKn6CxbEjvUEpsPL5G9KNOf7Q9lGMsolZs=";
            };
          };
        }
        { # Rapid tools for quick motion involving delimiters.
          name = "nvim-surround";
          lazy = false;
          pkg = pkgs.vimUtils.buildVimPlugin {
            name = "nvim-surround";
            src = pkgs.fetchFromGitHub {
              owner = "kylechui";
              repo = "nvim-surround";
              rev = "ec2dc7671067e0086cdf29c2f5df2dd909d5f71f";
              hash = "sha256-DCNfT//qMnzIu4V9or3Q39h4XzLz9P4twtHnQHV2rrQ=";
            };
          };
        }

        { # Two-char search for Neovim. Similar to seek, sneak, snipe, etc.
          name = "leap";
          lazy = false;
          pkg = pkgs.vimUtils.buildVimPlugin {
            name = "leap.nvim";
            src = pkgs.fetchFromGitHub {
              owner = "ggandor";
              repo = "leap.nvim";
              rev = "3b1d76ee9cd5a12a8f7a42f0e91124332860205c";
              hash = "sha256-SfBwuTZRg+SOS6nuF68zom4ohFwvi484FAaxjWWFMSA=";
            };
          };
        }

        { # Zen mode including Ataraxis and Focus modes.
          name = "true-zen";
          lazy = false;
          pkg = pkgs.vimUtils.buildVimPlugin {
            name = "true-zen.nvim";
            src = pkgs.fetchFromGitHub {
              owner = "pocco81";
              repo = "true-zen.nvim";
              rev = "2b9e210e0d1a735e1fa85ec22190115dffd963aa";
              hash = "sha256-euaxTWS98i14wvuKrFvdCRigsKqrSUwZpMEmYtUBBss=";
            };
          };
        }

        { # Org-mode like system for Neovim.
          name = "neorg";
          lazy = false;
          config = true;
          pkg = pkgs.vimUtils.buildVimPlugin {
            name = "neorg";
            src = pkgs.fetchFromGitHub {
              owner = "nvim-neorg";
              repo = "neorg";
              rev = "v9.1.1";
              hash = "sha256-f6hJbZEcf9XGTLxUikTOu2Kq53hlAC08JJbz76gQk6I=";
            };
          };
          dependencies = [
            pkgs.vimUtils.buildVimPlugin {
              name = "nvim-nio";
              pkg = pkgs.fetchFromGitHub {
                owner = "nvim-neotest";
                repo = "nvim-nio";
                rev = "v1.7.0";
                hash = "sha256-AWqF7EyhEi7kExOTJyLW/7ougsHJDP1rGYZxUOoMHow=";
              };
            }
            pkgs.vimUtils.buildVimPlugin {
              name = "lua-utils.nvim";
              pkg = pkgs.fetchFromGitHub {
                owner = "nvim-neorg";
                repo = "lua-utils.nvim";
                rev = "v1.0.2";
                hash = "sha256-9ildzQEMkXKZ3LHq+khGFgRQFxlIXQclQ7QU3fcU1C4=";
              };
            }
            pkgs.vimUtils.buildVimPlugin {
              name = "plenary.nvim";
              pkg = pkgs.fetchFromGitHub {
                owner = "nvim-lua";
                repo = "plenary.nvim";
                rev = "v0.1.4";
                hash = "sha256-zR44d9MowLG1lIbvrRaFTpO/HXKKrO6lbtZfvvTdx+o=";
              };
            }
            pkgs.vimUtils.buildVimPlugin {
              name = "nui.nvim";
              pkg = pkgs.fetchFromGitHub {
                owner = "MunifTanjim";
                repo = "nui.nvim";
                rev = "0.3.0";
                hash = "sha256-L0ebXtv794357HOAgT17xlEJsmpqIHGqGlYfDB20WTo=";
              };
            }
            pkgs.vimUtils.buildVimPlugin {
              name = "pathlib.nvim";
              pkg = pkgs.fetchFromGitHub {
                owner = "pysan3";
                repo = "pathlib.nvim";
                rev = "v2.2.0";
                hash = "sha256-3KdP79wOeh+RIbhd2nFVf5AuO9rXi+lbGTln8YEf1Ns=";
              };
            }
          ];
        }

        { # Vim tools for Nix.
          name = "vim-nix";
          ft = [ "nix" ];
          lazy = true;
          pkg = pkgs.vimUtils.buildVimPlugin {
            name = "vim-nix";
            src = pkgs.fetchFromGitHub {
              owner = "LnL7";
              repo = "vim-nix";
              rev = "e25cd0f2e5922f1f4d3cd969f92e35a9a327ffb0";
              hash = "sha256-2/9eyU+uUbcKiNcBDdgdxCBp1vNSP51U/0LTHihEYJY=";
            };
          };
        }
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
    extraConfigLua = ''
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
