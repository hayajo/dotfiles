syntax enable

" options {{{
set ambiwidth=double
set autochdir
set autoindent
set autoread
set background=dark
set backspace=eol,indent,start
set cindent
set clipboard+=unnamed
set cmdheight=1
set complete+=k
set completeopt=menuone,preview
set cursorline
set encoding=utf-8
set expandtab
set fileencodings=utf-8,iso-2022-jp,euc-jp,cp932
set fileformat=unix
set fileformats=unix,dos,mac
set helplang=en
set hidden
set history=2000
set hlsearch
set ignorecase
set incsearch
set laststatus=2
set list
set listchars=tab:▸\ ,eol:↲
set mouse=a
set nobackup
set nocompatible
set noerrorbells
set noswapfile
set notagbsearch
set novisualbell
set nowildmenu
set nowrap
set nowrapscan
"set number
set pastetoggle=<F10>
set ruler
set scrolloff=5
set shiftround
set shiftwidth=4
set showcmd
set showmatch
set smartcase
set smarttab
set softtabstop=4
set splitbelow
set splitright
set t_Co=256
set t_vb=
set tabstop=4
set termencoding=utf-8
set timeout timeoutlen=3000 ttimeoutlen=100
set undodir=~/.vimundo
set undofile
set virtualedit+=block
set whichwrap=h,l
set wildchar=<tab>
set wildmode=list:full
" }}} options

" keymaps {{{
let mapleader=","

nnoremap ; :
vnoremap ; :

nnoremap k  gk
nnoremap j  gj
vnoremap k  gk
vnoremap j  gj
nnoremap gk k
nnoremap gj j
vnoremap gk k
vnoremap gj j

nnoremap <silent> <Esc><Esc> :<C-u>nohlsearch<CR>

inoremap <C-f> <Right>
inoremap <C-b> <Left>
inoremap <C-n> <Down>
inoremap <C-p> <Up>
inoremap <C-a> <Home>
inoremap <C-e> <End>
inoremap <C-d> <Del>
inoremap <C-k> <Esc>ld$a

cnoremap <C-f> <Right>
cnoremap <C-b> <Left>
cnoremap <C-n> <Down>
cnoremap <C-p> <Up>
cnoremap <C-a> <Home>
cnoremap <C-d> <Del>
cnoremap <C-k> <C-\>e getcmdpos() == 1 ? '' : getcmdline()[:getcmdpos()-2]<CR>
" }}} keymaps

" statusline {{{
let ff_table = {'dos' : 'CR+LF', 'unix' : 'LF', 'mac' : 'CR' }
let &statusline='%<%f %h%m%r%w[%{(&fenc!=""?&fenc:&enc)}:%{ff_table[&ff]}]%y%= %-14.(%l,%c%V%) U+%04B %P'
" }}} statusline

" global_variables {{{
let g:netrw_dirhistmax = 0 " .netrwhistを作成しないようにヒストリ数をゼロに設定
" }}} global_variables

" color {{{
colorscheme industry
" }}} color

" disable auto comment {{{
augroup auto_comment_off
  autocmd!
  autocmd BufEnter * setlocal formatoptions-=r
  autocmd BufEnter * setlocal formatoptions-=o
augroup END
" }}} disable auto comment

if $USER != "root"
  if filereadable(expand('~/.vimrc.local'))
    source ~/.vimrc.local
  endif
  if filereadable(expand('~/.vimrc.dein')) && v:version >= 704
    source ~/.vimrc.dein
  endif
endif

" vim: foldmethod=marker
" vim: foldmarker={{{,}}}
