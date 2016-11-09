set nocompatible

set autochdir
set backspace=indent,eol,start
set clipboard=unnamed
set cursorline
set list
set listchars=tab:»\ ,eol:¬
" set completeopt=menuone,preview
set completeopt=menuone
"set hlsearch
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

let mapleader="\<Space>"

nnoremap ; :
vnoremap ; :

inoremap <C-a> <Home>
inoremap <C-b> <Home>
inoremap <C-e> <End>
inoremap <C-k> <Esc>ld$a

cnoremap <C-a> <Home>
cnoremap <C-k> <C-\>e getcmdpos() == 1 ? '' : getcmdline()[:getcmdpos()-2]<CR>

nnoremap <silent> <Esc><Esc> :<C-u>nohlsearch<CR>

nnoremap <expr> <Space>f ":e ".(expand("%:p") == "" ? getcwd() : expand("%:p:h"))."/"
nnoremap <Space><Space> :ls<CR>:buf 

" {{{ color
set t_Co=256
syntax on
colorscheme industry
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

" vim: foldmethod=marker
" vim: foldmarker={{{,}}}
