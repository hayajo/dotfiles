syntax enable

set ambiwidth=double
set autochdir
set autoindent
set autoread
set backspace=eol,indent,start
set cindent
set cursorline
set cmdheight=1
set complete+=k
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
set list
set listchars=tab:^\ ,trail:_,extends:>,precedes:<
set nobackup
set nocompatible
set noerrorbells
set noswapfile
set notagbsearch
set novisualbell
set nowildmenu
set nowrap
set nowrapscan
set pastetoggle=<F10>
set ruler
set scrolloff=5
set shiftround
set shiftwidth=2
set showcmd
set showmatch
set smartcase
set smarttab
set softtabstop=2
set splitbelow
set splitright
set t_Co=256
set tabstop=2
set termencoding=utf-8
set timeout timeoutlen=3000 ttimeoutlen=100
set undodir=~/.vimundo
set undofile
set t_vb=
set virtualedit+=block
set whichwrap=h,l
set wildchar=<tab>
set wildmode=list:full
set number

let mapleader="\<Space>"

nnoremap ; :
vnoremap ; :

nnoremap ga  ^
nnoremap ge  $

nnoremap k   gk
nnoremap j   gj
vnoremap k   gk
vnoremap j   gj
nnoremap gk  k
nnoremap gj  j
vnoremap gk  k
vnoremap gj  j

nmap <Leader><Leader> V

nnoremap <expr> n <SID>search_forward_p() ? 'nzv' : 'Nzv'
nnoremap <expr> N <SID>search_forward_p() ? 'Nzv' : 'nzv'
vnoremap <expr> n <SID>search_forward_p() ? 'nzv' : 'Nzv'
vnoremap <expr> N <SID>search_forward_p() ? 'Nzv' : 'nzv'

function! s:search_forward_p()
  return exists('v:searchforward') ? v:searchforward : 1
endfunction


nnoremap go  :<C-u>for i in range(v:count1) \| call append(line('.'), '') \| endfor<CR>
nnoremap gO  :<C-u>for i in range(v:count1) \| call append(line('.')-1, '') \| endfor<CR>

nnoremap <silent> <Esc><Esc> :<C-u>nohlsearch<CR>

inoremap jk <Esc>

nnoremap <Leader>s :<C-u>%s///g<Left><Left><Left>
vnoremap <Leader>s :s///g<Left><Left><Left>

nnoremap <Leader>e :e.<CR>

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

let g:netrw_dirhistmax = 0

colorscheme desert

if system("/usr/bin/id -u") > 0
  if filereadable(expand('~/.vimrc.local'))
    source ~/.vimrc.local
  endif

  if filereadable(expand('~/.vimrc.plugins'))
    source ~/.vimrc.plugins
  endif
endif
