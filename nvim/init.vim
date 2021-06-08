" This .vimrc file is heavily commented due to my attempt to pull unused
" options that had acumulated previously and understand every line in my
" configuration without having to pull up the help menu.

if has('osx')
  " Add path to fzf installed by Homebrew.
  set rtp+=/usr/local/opt/fzf
endif

" vim-polyglot includes vim-sensible by default. It needs to be disabled
" before the plugin is installed.
let g:polyglot_disabled = ['sensible']

" Install vim-plug if not found
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" Run PlugInstall if there are missing plugins
autocmd VimEnter * if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
      \| PlugInstall --sync | source $MYVIMRC
      \| endif

call plug#begin()

Plug 'airblade/vim-gitgutter'
Plug 'dracula/vim', { 'as': 'dracula' }
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'justinmk/vim-sneak'
Plug 'ms-jpq/chadtree', { 'branch': 'chad', 'do': 'python3 -m chadtree deps' }
Plug 'neoclide/coc.nvim', { 'branch': 'release' }
Plug 'rrethy/vim-illuminate'
Plug 'rrethy/vim-hexokinase', { 'do': 'make hexokinase' }
Plug 'sheerun/vim-polyglot'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

call plug#end()

" Enable 24-bit colors, all of them.
set termguicolors
colorscheme dracula

" Allow for hidden buffers. Necessary for some plugins.
set hidden

" coc.nvim recommends a lower updatetime.
set updatetime=500

" Don't pass messages to |ins-completion-menu|
set shortmess+=c

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved
set signcolumn=yes

" Don't show the mode as vim-airline will already display it for us
set noshowmode

" Highlight the cursor
set cursorline

" Show line numbers and make them relative to cursor
set number
set relativenumber

" Always show lines above and below cursor when scrolling
set scrolloff=3

" Always put splits below or to the right
set splitbelow
set splitright

" Set the title of the terminal window appropriately
set title

" Use two columns for tabs in insert mode and for reindent operations.
set softtabstop=2
set shiftwidth=2

" Expand tabs to spaces in insert mode.
set expandtab

" Wrap text at 80 chars and show the ruler at 81.
set textwidth=80
set colorcolumn=+1

" Show a symbol for wrapped lines.
set showbreak=↪

" Resize splits when the window is resized
au VimResized * :wincmd =

" Case insensitive, unless any caps are used
set ignorecase
set smartcase

" Disable the arrow keys now and forever...
nnoremap <up> <nop>
nnoremap <down> <nop>
nnoremap <left> <nop>
nnoremap <right> <nop>
inoremap <up> <nop>
inoremap <down> <nop>
inoremap <left> <nop>
inoremap <right> <nop>

" Use jk instead of escape for better ergonomics.
inoremap jj <esc>
inoremap <esc> <nop>

" Quit visual mode quickly.
vnoremap v <esc>

" Quickly move to the start and end of the line in normal mode.
nnoremap H ^
nnoremap L $

" Redo
nnoremap U <c-r>

" Quick command mode
nnoremap <cr> :

" Yank to the end of line
nnoremap Y y$

let g:mapleader = "\<Space>"
let g:maplocalleader = ','

" Buffers
nnoremap <leader>bd :bdelete<cr>
nnoremap <leader>bl :ls<cr>:b<space>
nnoremap <leader>bn :bnext<cr>
nnoremap <leader>bp :bprevious<cr>

" Code
nmap <leader>cd <plug>(coc-definition)
nnoremap <leader>cf :Rg<cr>
nmap <leader>ci <plug>(coc-implementation)
nmap <leader>cn <plug>(coc-diagnostic-next)
nmap <leader>cN <plug>(coc-diagnostic-prev)
nmap <leader>cq <plug>(coc-fix-current)
nmap <leader>cr <plug>(coc-rename)

" Files
nnoremap <leader>fc :edit $MYVIMRC<cr>
nnoremap <leader>fe :CHADopen<cr>
nnoremap <leader>ff :Files<cr>
nnoremap <leader>fr :source $MYVIMRC<cr>
nnoremap <leader>fs :update<cr>

" Git
nnoremap <leader>gf :GFiles<cr>
nnoremap <leader>gc :Git commit<cr>
nnoremap <leader>gg :Git<cr>
nnoremap <leader>gp :Git push<cr>

" Misc
nnoremap <leader>q :quit<cr>

let g:coc_global_extensions = [
      \ "coc-css",
      \ 'coc-cssmodules',
      \ 'coc-eslint',
      \ 'coc-html',
      \ 'coc-json',
      \ 'coc-prettier',
      \ 'coc-tsserver'
      \ ]

" Trigger completions with enter.
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<cr>"

" Navigate completions with Tab.
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

let g:chadtree_settings = {}
let g:chadtree_settings.theme = {}
let g:chadtree_settings.theme.discrete_colour_map = {
      \ "black": "#21222c",
      \ "red": "#ff5555",
      \ "green": "#50fa7b",
      \ "yellow": "#f1fa8c",
      \ "blue": "#bd93f9",
      \ "magenta": "#ff79c6",
      \ "cyan": "#8be9fd",
      \ "white": "#f8f8f2",
      \ "bright_black": "#6272a4",
      \ "bright_red": "#ff6e6e",
      \ "bright_green": "#69ff94",
      \ "bright_yellow": "#ffffa5",
      \ "bright_blue": "#d6acff",
      \ "bright_magenta": "#ff92df",
      \ "bright_cyan": "#a4ffff",
      \ "bright_white": "#ffffff"
      \ }

let g:chadtree_settings.options = {}
let g:chadtree_settings.options.close_on_open = v:true

let g:airline_theme='dracula'
let g:airline_symbols_ascii = 1

let g:airline_extensions = ['branch', 'coc']
let g:airline#extensions#branch#format = 'CustomBranchName'

function! CustomBranchName(name)
  let story = matchstr(a:name, '\Wch\d\+\W')
  
  if (strlen(story) > 0)
    return story[1:strlen(story) - 2]
  endif

  return a:name[:9]
endfunction

let g:vim_jsx_pretty_colorful_config = 1

