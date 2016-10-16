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

set ignorecase
set smartcase

set autoindent
set expandtab
set shiftwidth=4
set softtabstop=4
set tabstop=4

set hidden

let mapleader=","

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
let g:netrw_altv=1
let g:netrw_alto=1
" }}} netrw

" {{{ ジャンクファイル作成
function! s:open_junk_file()
  if !exists('g:junk_file_basedir')
    let g:junk_file_basedir=$HOME . '/.vim_junk'
  endif
  let l:junk_file_dir=g:junk_file_basedir . strftime('/%Y/%m')
  if !isdirectory(l:junk_file_dir)
    call mkdir(l:junk_file_dir, 'p')
  endif
  let l:filename=input('Junk Code: ', l:junk_file_dir . strftime('/%Y-%m-%d-%H%M%S.'))
  if l:filename!=''
    execute 'edit ' . l:filename
  endif
endfunction

command! -nargs=0 JunkFile call s:open_junk_file()

nnoremap <Leader>jf :JunkFile<CR>
" }}} ジャンクファイル作成

" {{{ junegunn/vim-plug
if has('vim_starting')
	set runtimepath+=~/.vim/bundle/vim-plug.vim/
endif
call plug#begin('~/.vim/plugged')
Plug 'scrooloose/nerdcommenter'
Plug 'vim-scripts/YankRing.vim'
Plug 'tpope/vim-surround'
Plug 'fatih/vim-go'
Plug 'Shougo/neomru.vim' | Plug 'Shougo/unite.vim'
if has('lua')
    Plug 'ujihisa/neco-look' | Plug 'Shougo/neocomplete.vim'
endif
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
autocmd FileType go nmap <leader>gr <Plug>(go-run)
autocmd FileType go nmap <leader>gb <Plug>(go-build)
autocmd FileType go nmap <leader>gt <Plug>(go-test)
" }}} fatih/vim-go

" {{{ Shougo/unite.vim
nnoremap [unite] <Nop>
nmap     <Space> [unite]

nnoremap <silent> [unite]<Space> :<C-u>Unite buffer file_mru directory_mru<CR>
nnoremap <silent> [unite]f       :<C-u>UniteWithBufferDir -buffer-name=files file file/new directory/new<CR>

call unite#custom#profile('default', 'context', {
      \   'start_insert': 1,
      \   'winheight': 10,
      \   'direction': 'botright',
      \ })
" call unite#custom#source('file', 'matchers', "matcher_default")

autocmd FileType unite call s:unite_my_settings()
function! s:unite_my_settings()
  imap <buffer> <Esc><Esc> <Esc><Plug>(unite_all_exit)
  imap <buffer> <C-w> <Plug>(unite_delete_backward_path)
  imap <buffer> <C-k> <Plug>(unite_select_previous_line)
  imap <buffer> <C-j> <Plug>(unite_select_next_line)
  imap <buffer><expr> <C-s> unite#do_action('below')
  imap <buffer><expr> <C-v> unite#do_action('right')
endfunction
" }}} Shougo/unite.vim

" {{{ Shougo/neocomplete
let g:acp_enableAtStartup=0
let g:neocomplete#enable_at_startup=1
let g:neocomplete#enable_smart_case=1
let g:neocomplete#sources#syntax#min_keyword_length=3
let g:neocomplete#lock_buffer_name_pattern='\*ku\*'

inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function()
  return (pumvisible() ? "\<C-y>" : "" ) . "\<CR>"
endfunction
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"

if !exists('g:neocomplete#keyword_patterns')
  let g:neocomplete#keyword_patterns = {}
endif
let g:neocomplete#keyword_patterns['default'] = '\h\w*'

if !exists('g:neocomplete#sources#omni#input_patterns')
  let g:neocomplete#sources#omni#input_patterns = {}
endif
let g:neocomplete#sources#omni#input_patterns.go = '[^.[:digit:] *\t]\.\w*'
" }}} Shougo/neocomplete

" vim: foldmethod=marker
" vim: foldmarker={{{,}}}
