" Much of this was adapted from
" http://stevelosh.com/blog/2010/09/coming-home-to-vim/

" Pathogen
filetype off
call pathogen#runtime_append_all_bundles()
filetype plugin indent on

" No vi compatibility
set nocompatible
set modelines=0

" Spaces and Tabs
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab
set smarttab
set smartindent
set autoindent

" Treat underscore as word delimiter
set iskeyword-=_

" Backspace in insert mode
set backspace=indent,eol,start

" Status
set laststatus=2
set statusline=%-3.n%t\ %m\ %y%=%l/%L\ %c\ %P

" Basic settings
set encoding=utf-8
set scrolloff=3
set showmode
set showcmd
set hidden
set wildmenu
set wildmode=list,longest
set visualbell
set cursorline
set ttyfast
set ruler
set title
set autoread
set showmatch
set undofile

" Use relative line numbers
set relativenumber

" Search
nnoremap / /\v
vnoremap / /\v
set ignorecase
set smartcase
set gdefault
set incsearch
set showmatch
set hlsearch
nnoremap <leader><space> :noh<cr>
nnoremap <tab> %
vnoremap <tab> %

" Handling long lines
set wrap
set textwidth=79
set formatoptions=qrn1
set colorcolumn=81

" Color
syntax enable
set background=dark
colorscheme solarized

" Use Vim Correctly!
nnoremap <up> <nop>
nnoremap <down> <nop>
nnoremap <left> <nop>
nnoremap <right> <nop>
inoremap <up> <nop>
inoremap <down> <nop>
inoremap <left> <nop>
inoremap <right> <nop>
nnoremap j gj
nnoremap k gk

" Remap for help key
inoremap <F1> <ESC>
nnoremap <F1> <ESC>
vnoremap <F1> <ESC>

" Same key!
nnoremap ; :

" Save on lost focus
au FocusLost * :wa

let python_space_errors = 1
let c_space_errors = 1
let javascript_space_errors = 1
let c_C99 = 1

let mapleader = ","
