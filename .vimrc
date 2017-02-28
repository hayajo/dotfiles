set nocompatible

set autochdir
set backspace=indent,eol,start
set clipboard=unnamed
set cursorline
set list
set listchars=tab:»\ ,eol:¬
" set completeopt=menuone,preview
set completeopt=menuone
set hlsearch
set noswapfile
set number

set ignorecase
set smartcase

set autoindent
set expandtab
set shiftwidth=4
set softtabstop=4
set tabstop=4

set hidden

set wildmenu
set wildmode=longest,full

set updatetime=300

" let mapleader="\<Space>"
let mapleader=","
nmap <Leader>bd :bdelete<CR>

nnoremap ; :
vnoremap ; :

inoremap <C-a> <Home>
inoremap <C-b> <Home>
inoremap <C-e> <End>
inoremap <C-k> <Esc>ld$a

cnoremap <C-a> <Home>
cnoremap <C-k> <C-\>e getcmdpos() == 1 ? '' : getcmdline()[:getcmdpos()-2]<CR>

nnoremap <silent> <Esc><Esc> :<C-u>nohlsearch<CR>

" {{{ color
set t_Co=256
syntax on
" colorscheme industry
highlight PmenuSel ctermfg=0 ctermbg=13 guibg=Magenta
highlight Pmenu ctermfg=242 ctermbg=233 guibg=DarkGrey
" }}} color

" {{{ statusline
set cmdheight=1
set laststatus=2
let ff_table = {'dos' : 'CR+LF', 'unix' : 'LF', 'mac' : 'CR' }
let &statusline='%<%f %h%m%r%w[%{(&fenc!=""?&fenc:&enc)}:%{ff_table[&ff]}]%y%= %-14.(%l,%c%V%) U+%04B %P'
" }}} statusline

" {{{ netrw
" let g:netrw_liststyle=3 " ツリー表示
" let g:netrw_altv=1
" let g:netrw_alto=1
let g:netrw_keepdir=0
" }}} netrw

" {{{ junegunn/vim-plug
if has('vim_starting')
	set runtimepath+=~/.vim/bundle/vim-plug.vim/
endif
call plug#begin('~/.vim/plugged')
Plug 'scrooloose/nerdcommenter'
Plug 'vim-scripts/YankRing.vim'
Plug 'tpope/vim-surround'
Plug 'fatih/vim-go'
Plug 'osyo-manga/vim-brightest'
Plug 'Shougo/junkfile.vim'
Plug 'kien/ctrlp.vim'
Plug 'hayajo/ctrlp-filer', {'branch': 'mine'}
call plug#end()
" }}} junegunn/vim-plug

" {{{ scrooloose/nerdcommenter
let g:NERDCreateDefaultMappings=0
let g:NERDSpaceDelims=1
let g:NERDTrimTrailingWhitespace=1

nmap <Leader>cc <plug>NERDCommenterToggle
vmap <Leader>cc <plug>NERDCommenterToggle
nmap <Leader>cd <plug>NERDCommenterAppend
vmap <Leader>cd <plug>NERDCommenterAppend
" }}} scrooloose/nerdcommenter

" {{{ fatih/vim-go
let g:go_highlight_functions=1
let g:go_highlight_methods=1
let g:go_highlight_structs=1
let g:go_fmt_command="goimports"

autocmd FileType go :highlight goErr cterm=bold ctermfg=214
autocmd FileType go :match goErr /\<err\>/
autocmd FileType go nmap <Leader>gi :GoImport 
autocmd FileType go nmap <Leader>gl :GoLint<CR>
autocmd FileType go nmap <leader>gr <Plug>(go-run)
autocmd FileType go nmap <leader>gb <Plug>(go-build)
autocmd FileType go nmap <leader>gt <Plug>(go-test)
" }}} fatih/vim-go

" {{{ osyo-match/vim-brightest
let g:brightest#highlight = {
            \ "group": "BrightestReverse",
            \ }
let g:brightest#enable_on_CursorHold=1
" }}} osyo-match/vim-brightest

" {{{ Shougo/junkfile.vim
nnoremap <Leader>jf :JunkfileOpen<CR>
" }}} Shougo/junkfile.vim

" {{{ kien/ctrlp.vim
let g:ctrlp_map='<Nop>'
let g:ctrlp_max_files =100000
let g:ctrlp_max_depth=10
let g:ctrlp_clear_cache_on_exit=0
let g:ctrlp_mruf_max=500
let g:ctrlp_match_window='bottom,order:btt,min:1,max:10,results:50'
let g:ctrlp_open_new_file='r'
nnoremap <silent> <Space>b :CtrlPBuffer<CR>
nnoremap <silent> <Space><Space> :CtrlPMRUFiles<CR>
nnoremap <silent> <Space>f :CtrlPFiler<CR>
set splitright
set splitbelow
" }}} kien/ctrlp.vim

" vim: foldmethod=marker
" vim: foldmarker={{{,}}}
