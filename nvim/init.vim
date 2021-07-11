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

" Set the leader before plugins might add their own mappings.
let mapleader = ' '
let maplocalleader = ' '

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
Plug 'machakann/vim-sandwich'
Plug 'ms-jpq/chadtree', { 'branch': 'chad', 'do': 'python3 -m chadtree deps' }
Plug 'neoclide/coc.nvim', { 'branch': 'release' }
Plug 'sheerun/vim-polyglot'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

call plug#end()

" Use vim-surround mappings to not conflict with vim-sneak.
runtime macros/sandwich/keymap/surround.vim

" Enable 24-bit colors, all of them.
set termguicolors
colorscheme dracula

" Allow for hidden buffers. Necessary for some plugins.
set hidden

" coc.nvim recommends a lower updatetime, which is used by the highlight on
" CursorHold feature.
set updatetime=500

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
set signcolumn=yes

" Don't show the mode as vim-airline will already display it for us.
set noshowmode

" Show line numbers and make them relative to cursor.
set number
set relativenumber

" Always show lines above and below cursor when scrolling.
set scrolloff=3

" Always put splits below or to the right.
set splitbelow
set splitright

" Set the title of the terminal window appropriately.
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

" Resize splits when the window is resized.
au VimResized * :wincmd =

" Case insensitive, unless any caps are used.
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

" Use jj instead of escape for better ergonomics.
inoremap jj <esc>

" Quickly move to the start and end of the line in normal mode.
nnoremap H ^
nnoremap L $

" Redo
nnoremap U <c-r>

" Quick command mode
nnoremap <cr> :

" LSP
xmap <leader>a <plug>(coc-codeaction-selected)
nmap <leader>a <plug>(coc-codeaction-selected)
nmap <leader>ac <Plug>(coc-codeaction)
nmap <leader>d <plug>(coc-definition)
nmap <leader>dn <plug>(coc-diagnostic-next)
nmap <leader>dp <plug>(coc-diagnostic-prev)
nmap <leader>fq <plug>(coc-fix-current)
nmap <leader>i <plug>(coc-implementation)
nnoremap <silent> K <cmd>call <sid>show_documentation()<cr>
nmap <leader>rn <plug>(coc-rename)
nmap <leader>rr <plug>(coc-references)

" Files
nnoremap <leader>fc <cmd>bdelete<cr>
nnoremap <leader>fe <cmd>CHADopen<cr>
nnoremap <leader>ff <cmd>Rg<cr>
nnoremap <leader>fl :ls<cr>:b<space>
nnoremap <leader>fn <cmd>bnext<cr>
nnoremap <leader>fo <cmd>Files<cr>
nnoremap <leader>fp <cmd>bprevious<cr>
nnoremap <leader>fs <cmd>update<cr>

" Git
nnoremap <leader>g <cmd>Git<cr>

" Quickly clear search highlighting.
nnoremap <leader>n <cmd>noh<cr>

" Quit
nnoremap <leader>q <cmd>quit<cr>
nnoremap <leader>Q <cmd>quit!<cr>

" Vim configuration
nnoremap <leader>v <cmd>edit $MYVIMRC<cr>

" Make the fuzzy finder floating window bigger.
let g:fzf_layout = { 'window': { 'width': 0.8, 'height': 0.8 } }

" CoC Extensions. These should be automatically installed by coc.nvim.
let g:coc_global_extensions = [
      \ "coc-css",
      \ 'coc-cssmodules',
      \ 'coc-eslint',
      \ 'coc-html',
      \ 'coc-json',
      \ 'coc-prettier',
      \ 'coc-tsserver',
      \ 'coc-vimlsp'
      \ ]

" Show documentation in preview window.
function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

" Trigger completions with enter.
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<cr>"

" Navigate completions with Tab.
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Use dracula in CHADTree. The close_on_open setting is nice because it prevents
" us from accidentally opening a different buffer in that window, which leads to
" odd settings for that buffer.
let g:chadtree_settings = {
      \ "theme": {
        \ "discrete_colour_map": {
          \ "black": g:dracula#palette.color_0,
          \ "red": g:dracula#palette.color_1,
          \ "green": g:dracula#palette.color_2,
          \ "yellow": g:dracula#palette.color_3,
          \ "blue": g:dracula#palette.color_4,
          \ "magenta": g:dracula#palette.color_5,
          \ "cyan": g:dracula#palette.color_6,
          \ "white": g:dracula#palette.color_7,
          \ "bright_black": g:dracula#palette.color_8,
          \ "bright_red": g:dracula#palette.color_9,
          \ "bright_green": g:dracula#palette.color_10,
          \ "bright_yellow": g:dracula#palette.color_11,
          \ "bright_blue": g:dracula#palette.color_12,
          \ "bright_magenta": g:dracula#palette.color_13,
          \ "bright_cyan": g:dracula#palette.color_14,
          \ "bright_white": g:dracula#palette.color_15,
          \ }
        \ },
        \ "options": {
          \ "close_on_open": v:true
          \ }
      \ }

" Use dracula and keep it simple.
let g:airline_theme='dracula'
let g:airline_symbols_ascii = 1

if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif

" Remove the space before the line number prefix since we are removing the
" percentage indicator (see below).
let g:airline_symbols.linenr = 'ln:'

" Disable most extensions by default.
let g:airline_extensions = ['branch', 'coc']

" Use a custom function to get the git branch text.
let g:airline#extensions#branch#format = 'GetGitBranch'

function! GetGitBranch(name)
  " Clubhouse git branches will contain the ticket identifier preceded by "ch".
  let story = matchstr(a:name, 'ch\d\+')
  
  " Use the "ch" identifier if we found one.
  if (strlen(story) > 0)
    return story[:strlen(story) - 1]
  endif

  " Otherwise the first ten characters.
  return a:name[:9]
endfunction

" Remove the document percentage indicator.
function! AirlineInit()
  let g:airline_section_z = airline#section#create(['linenr', 'maxlinenr', 'colnr'])
endfunction
autocmd User AirlineAfterInit call AirlineInit()

" More colorful JSX.
let g:vim_jsx_pretty_colorful_config = 1
