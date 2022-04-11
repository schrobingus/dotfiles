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
	Plug 'jeffkreeftmeijer/vim-dim'
call plug#end()

" Set the theme (default is Dim, since it's the most agnostic).
colorscheme dim

" Enable the mouse.
set mouse=a

" Enable the clipboard.
set clipboard=unnamedplus

" Disable case sensitivity.
set ignorecase

" Set numberlines
set number
