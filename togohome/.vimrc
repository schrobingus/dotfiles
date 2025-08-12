
" If you are looking for my full fledged Vim config rather than
" a minimal declaration that can be used universally on any
" device, you are likely looking for `schrobingus/nixvim-config`

set nocompatible

let mapleader = " "

set number
set wrap
set showcmd
set showmode
set hlsearch
set ignorecase
set smartcase
set autoindent
set expandtab
set tabstop=2
set shiftwidth=2
set mouse=a
set clipboard=unnamedplus

nnoremap ; :
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

inoremap jk <Esc>
inoremap <C-h> <Left>
inoremap <C-j> <Down>
inoremap <C-k> <Up>
inoremap <C-l> <Right>

nnoremap d "_d
xnoremap d "_d

