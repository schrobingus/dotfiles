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
	Plug 'pradyungn/Mountain', {'rtp': 'vim'}
	Plug 'arcticicestudio/nord-vim'

	" Sensible defaults for Vim.
	Plug 'tpope/vim-sensible'

	" Install Nix support for Vim.
	Plug 'LnL7/vim-nix'
call plug#end()

" Set the theme (default is Dim, since it's the most agnostic).
"colorscheme dim
"colorscheme mountain
colorscheme nord

" Optionally enable the Mountain statusline.
"let g:enable_mountain_statusline=1

" Enable the mouse.
set mouse=a

" Enable the clipboard.
set clipboard=unnamedplus

" Disable case sensitivity.
set ignorecase

" Set numberlines
set number
