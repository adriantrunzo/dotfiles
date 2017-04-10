" This .vimrc file is heavily commented due to my attempt to pull unused
" options that had acumulated previously and understand every line in my
" configuration without having to pull up the help menu.

runtime autoload/vim-plug/plug.vim

""" Plugins
call plug#begin()

" General
Plug 'scrooloose/nerdcommenter'
Plug 'vim-syntastic/syntastic'

" Languges
Plug 'othree/html5.vim'
Plug 'rust-lang/rust.vim'
Plug 'pangloss/vim-javascript'
Plug 'elzr/vim-json'
Plug 'Vimjas/vim-python-pep8-indent'

" Appearance
Plug 'altercation/vim-colors-solarized'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

call plug#end()


""" General Settings

" No vi compatibility
set nocompatible

" Do not look for vi variables at beginning or end of files
set modelines=0

" Treat underscore as word delimiter
set iskeyword-=_

" Enable filetype and indent detection
filetype plugin indent on

" More helpful backspace in insert mode. See a more detailed explanation
" here: http://vi.stackexchange.com/a/2163.
set backspace=indent,eol,start

" Allow for hidden buffers
set hidden

" Use utf-8 by default
set encoding=utf-8

" Detect file changes outside of vim and reload those files
set autoread


""" Visual Settings

" Highlight the cursor
set cursorline

" Always show the status line
set laststatus=2

" Unclear if this option is really necessary
set lazyredraw

" Show line numbers and make them relative to cursor
set number
set relativenumber

" Show the line and column number of the cursor
set ruler

" Always show lines above and below cursor when scrolling
set scrolloff=3

" Show partial command in last line
set showcmd

" Show the current mode in last line
set showmode

" Always put splits below or to the right
set splitbelow
set splitright

" Set the title of the terminal window appropriately
set title

" Don't beep!
set visualbell

" Colorscheme
syntax enable
set background=dark
silent! colorscheme solarized

" Resize splits when the window is resized
au VimResized * :wincmd =


""" Spaces and Tabs

" tabstop: how many columns to display for each tab character.
" softtabstop: how many columns are used for tab key in insert mode.
" shiftwidth: how many columns are used for reindent operations.
" expandtab: tabs are automatically expanded to spaces in insert mode.
" NOTE that without expandtab vim will minimize use of spaces if sts < ts
set tabstop=8
set softtabstop=4
set shiftwidth=4
set expandtab

" Create new lines at the same indentation level
set autoindent


""" Line length and Wrapping

" In general keep lines to less than 80 characters and wrap if necessary.
" For more detail on the format options, see "help: fo-table"

set wrap  " no hortizontal scrolling, please!
set textwidth=80
set formatoptions=tcn1
set colorcolumn=+1
set showbreak=↪

" Don't try to highlight lines longer than 800 characters.
set synmaxcol=800


""" Wildmenu

" Enable wildmenu (command-line completion). We want to list all matches and
" fill to the longest shared prefix. Don't bother showing some temporary
" files.

set wildmenu
set wildmode=list:longest
set wildignore+=*.DS_Store
set wildignore+=*.pyc
set wildignore+=*.orig


""" Search

" Substitutions always have the 'g' flag
set gdefault

" Highlight search results
set hlsearch

" Case insensitive, unless any caps are used
set ignorecase
set smartcase

" Show matches as search proceeds
set incsearch


""" Use Vim Correctly!

" Disable the arrow keys now and forever...

nnoremap <up> <nop>
nnoremap <down> <nop>
nnoremap <left> <nop>
nnoremap <right> <nop>
inoremap <up> <nop>
inoremap <down> <nop>
inoremap <left> <nop>
inoremap <right> <nop>


""" Filetype settings

" Javascript: Use two spaces
autocmd FileType javascript call UseTwoSpaces()

" CSS: Use two spaces
autocmd FileType css call UseTwoSpaces()

" HTML/XML: Use two spaces and don't break at textwidth
autocmd FileType html,xml call UseTwoSpaces() | call DontBreakText()

" Markdown: Don't break lines
autocmd FileType markdown call DontBreakText()

function UseTwoSpaces()
    setlocal shiftwidth=2
    setlocal softtabstop=2
endfunction

function DontBreakText()

    " Setting textwidth to zero will also remove the color column due to "+1"
    setlocal textwidth=0

    " Don't break text or comments.
    setlocal formatoptions-=tc

    " Move cursor up/down by screen line, not file line. This is helpful for
    " wrapped lines.
    " See http://vim.wikia.com/wiki/Move_cursor_by_display_lines_when_wrapping.
    nnoremap j gj
    nnoremap k gk
endfunction


""" Plugin settings

" vim-airline
let g:airline_theme='solarized'
let g:airline_powerline_fonts=1
let g:airline_left_sep=''
let g:airline_right_sep=''

" Syntastic
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_stl_format='[%E{Err: %fe #%e}%B{, }%W{Warn: %fw #%w}]'


""" Leader key and macros

let mapleader = ","

" Strip all trailing whitespace in current file
nnoremap <leader>W :%s/\s\+$//<cr>:let @/=''<CR>

" Re-hardwrap paragraphs of text
nnoremap <leader>q gqip

" Toggle spell-check
" https://github.com/jmdeldin/dotfiles/blob/master/.vimrc
nnoremap <leader>s :setlocal spell! spelllang=en_us<CR>

" Turn off any highlighting and clear search matches
noremap <leader><space> :noh<cr>:call clearmatches()<cr>
