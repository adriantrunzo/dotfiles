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
set tabstop=2
set softtabstop=2
set shiftwidth=2
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
set statusline=%-2.n\ %t\ %y " Buffer number, file name, file type 
set statusline+=%(\ %r%m%) " Read only and modfified flags
set statusline+=%(\ %{SyntasticStatuslineFlag()}%) " Syntastic!
set statusline+=%= " Left/Right breaker
set statusline+=%l/%L\ %c\ %P " Line number, column number, percentage

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

" Read html files as jinja syntax
au BufRead,BufNewFile *.html set filetype=htmljinja

au FileType python setlocal tabstop=4 softtabstop=4 shiftwidth=4

" Syntastic
let g:syntastic_check_on_open=1
let g:syntastic_stl_format='[%E{Err: %fe #%e}%B{, }%W{Warn: %fw #%w}]'

let mapleader = ","

" Strip all trailing whitespace in current file
nnoremap <leader>W :%s/\s\+$//<cr>:let @/=''<CR>

" Re-hardwrap paragraphs of text
nnoremap <leader>q gqip
