" leader key is comma
let mapleader=" "

" colorsscheme  " awesome colorsscheme

" enable syntax processing
syntax enable

" number of visual spaces per TAB
set tabstop=4

" number of spaces in tab when editing
set softtabstop=4

" tabs are spaces
set expandtab

" move vertically by visual line
nnoremap j gj
nnoremap k gk

" yank end of line
nnoremap Y y$

" always yank to system clipboard
set clipboard=unnamed

" move to beginning/end of line
nnoremap B ^
nnoremap E $

" $/^ doesn't do anything
nnoremap $ <nop>
nnoremap ^ <nop>

" remap esc key 
inoremap jj <Esc>
inoremap kk <Esc>
inoremap jk <Esc>

" show line numbers
set number

" show command in bottom bar
set showcmd

" highlight current line
set cursorline

" visual autocomplete for command menu
set wildmenu

" redraw only when we need to
set lazyredraw

" highlight matching [{()}]
set showmatch

" search as characters are entered
set incsearch

" highlight matches
set hlsearch

" turn off search highlight
nnoremap <leader><space> :nohlsearch<CR>

" highlight last inserted text
nnoremap gV `[v`]

" install plugins
