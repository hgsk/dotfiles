" pathogen
call pathogen#infect()

" encoding
set encoding=utf-8

" basic
set nocompatible
set number
set hidden
set title
set ruler
set showmatch
set autoread
set whichwrap=b,s,h,l,<,>,[,]
syntax on
filetype plugin indent on
set autochdir

" indent
set shiftwidth=2
set expandtab

" search
set ignorecase
set smartcase
set noincsearch
set hlsearch

" keymap
noremap W w
noremap Q q

" completion
set history=1000
