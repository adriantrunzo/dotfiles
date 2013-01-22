" Much of this was adapted from
" http://stevelosh.com/blog/2010/09/coming-home-to-vim/

" Pathogen
filetype off
call pathogen#infect()
filetype plugin indent on

" No vi compatibility
set nocompatible
set modelines=0
set lazyredraw

" Spaces and Tabs
set tabstop=8
set softtabstop=4
set shiftwidth=4
set expandtab
set autoindent
set shiftround
"
" Handling long lines
set wrap
set textwidth=80
set formatoptions=qrn1
set colorcolumn=81
set showbreak=↪

" Backups and swaps
set backup
set noswapfile
set undodir=~/.vim/tmp/undo//     " undo files
set backupdir=~/.vim/tmp/backup// " backups
set directory=~/.vim/tmp/swap//   " swap files

" Make those folders automatically if they don't already exist.
if !isdirectory(expand(&undodir))
    call mkdir(expand(&undodir), "p")
endif
if !isdirectory(expand(&backupdir))
    call mkdir(expand(&backupdir), "p")
endif
if !isdirectory(expand(&directory))
    call mkdir(expand(&directory), "p")
endif

" Don't try to highlight lines longer than 800 characters.
set synmaxcol=800

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
set visualbell
set cursorline
set ttyfast
set ruler
set title
set autowrite
set autoread
set showmatch
set undofile
set splitbelow
set splitright

" Use relative line numbers
set relativenumber

" Wildmenu
set wildmenu
set wildmode=list:longest
set wildignore+=.hg,.git,.svn
set wildignore+=*.sw?
set wildignore+=*.DS_Store
set wildignore+=*.pyc
set wildignore+=*.orig

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
au FocusLost * :silent! wall

" Resize splits when the window is resized
au VimResized * :wincmd =

" Read html files as jinja syntax
au BufRead,BufNewFile *.html set filetype=htmljinja

au FileType javascript,html,css,php setlocal tabstop=4 softtabstop=2 shiftwidth=2

" Syntastic
let g:syntastic_check_on_open=1
let g:syntastic_stl_format='[%E{Err: %fe #%e}%B{, }%W{Warn: %fw #%w}]'

let mapleader = ","

" Strip all trailing whitespace in current file
nnoremap <leader>W :%s/\s\+$//<cr>:let @/=''<CR>

" Re-hardwrap paragraphs of text
nnoremap <leader>q gqip
