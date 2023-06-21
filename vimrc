" Disable classic Vi compatibility.
set nocompatible

" Bootstrap Vim-plug.
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall | source $MYVIMRC
endif

" Add the packages via Vim-plug.
call plug#begin()
	" Themes for Vim.
	Plug 'arcticicestudio/nord-vim' " Nord theme.
  Plug 'wojciechkepka/vim-github-dark' " GitHub Dark theme.
	Plug 'jeffkreeftmeijer/vim-dim' " Terminal-gnostic theme.

	" Sensible defaults for Vim.
	Plug 'tpope/vim-sensible'

	" Install Nix support for Vim.
	Plug 'LnL7/vim-nix'
call plug#end()

" Set the theme.
" let g:gh_color = "soft"
colorscheme dim

" Remap ESC to jj.
imap jj <Esc>

" Enable the mouse.
set mouse=a

" Enable the clipboard.
set clipboard=unnamed

" Tabs should only be 2 spaces.
set expandtab
set tabstop=2
set shiftwidth=2

" Disable case sensitivity.
set ignorecase

" Enable black hole register.
nnoremap d "_d
xnoremap d "_d

" Enable number lines and line wrapping.
set number
set wrap
