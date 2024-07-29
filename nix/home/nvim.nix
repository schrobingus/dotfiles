{ inputs, pkgs, ... }:

{
  imports = [
    inputs.nixvim.homeManagerModules.nixvim
  ];

  programs.nixvim = {
    enable = true;

    plugins.lazy = {
      enable = true;

      plugins = [
        {
          name = "nvim-treesitter";
          lazy = false;
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

        {
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
        {
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

        {
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
        {
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
        {
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

        {
          name = "autoclose";
          lazy = false;
          pkg = pkgs.vimUtils.buildVimPlugin {
            name = "autoclose.nvim";
            src = pkgs.fetchFromGitHub {
              owner = "m4xshen";
              repo = "autoclose.nvim";
              rev = "b2077aa2c83df7ebc19b2a20a3a0654b24ae9c8f";
              hash = "sha256-mIInxvk4CQ6gXVTPyGNTFHpmtCYb8J5U+99+NyyPSmM=";
            };
          };
        }
        {
          name = "nvim-surround";
          lazy = false;
          /* opts.keymaps = {
            normal = "s";
            normal_cur = "ss";
            visual = "s";
            visual_line = "gs";
            }; */
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

        {
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

      autoread = true;
      lazyredraw = true;
      showmatch = true;

      expandtab = true;
      tabstop = 2;
      softtabstop = 2;
      shiftwidth = 2;
      autoindent = true;
      cindent = true;
      smartindent = true;
      smarttab = true;

      scrolloff = 6;

      backspace = "indent,eol,start";

      # listchars = "trail:▶";
    };

    clipboard = {
      register = "unnamedplus";

      providers.wl-copy.enable = true;
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
    '';
  };
}
