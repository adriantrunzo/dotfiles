" Pathogen
call pathogen#infect()

" Spaces and Tabs
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab
set smarttab
set smartindent
set autoindent

" Backspace in insert mode
set backspace=indent,eol,start

" Status
set laststatus=2
set statusline=%-3.n%t\ %m\ %y%=%l/%L\ %c\ %P

" Other
set number
set fileencodings=utf-8
set nocompatible
set scrolloff=3
set hidden
set wildmenu
set wildmode=list,longest
set visualbell
set ruler
set title
set autoread
set showcmd
set showmatch

" Search
set hlsearch
set ignorecase
set smartcase
set incsearch 

" File-type highlighting and configuration.
" Run :filetype (without args) to see what you may have
" to turn on yourself, or just set them all to be sure.
" http://items.sjbach.com/319/configuring-vim-right
filetype on
filetype plugin on
filetype indent on

" Color
" https://github.com/altercation/solarized
syntax enable
set background=dark
colorscheme solarized

nnoremap j gj
nnoremap k gk

let python_space_errors = 1
let c_space_errors = 1
let javascript_space_errors = 1
let c_C99 = 1

let mapleader = ","
