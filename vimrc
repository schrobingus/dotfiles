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
	Plug 'kaicataldo/material.vim' " Material theme.
	Plug 'jeffkreeftmeijer/vim-dim' " Terminal-gnostic theme.

	" Sensible defaults for Vim.
	Plug 'tpope/vim-sensible'

	" Install Nix support for Vim.
	Plug 'LnL7/vim-nix'
call plug#end()

" Set the theme.
colorscheme material

" These are settings specific to Material.
let g:material_terminal_italics = 1 " Enable italics.
let g:material_theme_style = 'darker' " Use the darker theme.

" Enable the mouse.
set mouse=a

" Enable the clipboard.
set clipboard=unnamed

" Disable case sensitivity.
set ignorecase

" Enable numberlines and line wrapping.
set number
set wrap
