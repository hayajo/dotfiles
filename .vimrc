set nocompatible
set autochdir
set hidden
set clipboard=unnamed
set backspace=2
set number
set cursorline
set list
set listchars=tab:»\ ,eol:¬
set noswapfile
set updatetime=300
set incsearch
set ignorecase
set smartcase
"set hlsearch
set autoindent
set expandtab
set shiftwidth=4
set softtabstop=4
set tabstop=4
set showmatch
set matchtime=1
"set wildmenu
set wildmode=list,full
set display=lastline
set pumheight=10

" let mapleader="\<Space>"
let mapleader=","

nnoremap ; :
vnoremap ; :

nnoremap Y y$
nnoremap + <C-a>
nnoremap - <C-x>

" {{{ color
set t_Co=256
syntax on
" colorscheme industry
highlight Pmenu ctermbg=8 ctermfg=0
highlight PmenuSel term=bold ctermbg=5 ctermfg=0
" }}} color

" {{{ statusline
set cmdheight=1
set laststatus=2
let ff_table={'dos' : 'CR+LF', 'unix' : 'LF', 'mac' : 'CR' }
let &statusline='%<%f %h%m%r%w[%{(&fenc!=""?&fenc:&enc)}:%{ff_table[&ff]}]%y%= %-14.(%l,%c%V%) U+%04B %P'
" }}} statusline

" {{{ netrw
let g:netrw_alto=1
let g:netrw_altv=1
let g:netrw_keepdir=0
" let g:netrw_liststyle=2
let g:netrw_special_syntax= 1
"let g:netrw_browse_split=4
" }}} netrw

" {{{ junegunn/vim-plug
if has('vim_starting')
	set runtimepath+=~/.vim/bundle/vim-plug.vim/
endif
call plug#begin('~/.vim/plugged')
Plug 'scrooloose/nerdcommenter'
Plug 'tpope/vim-surround'
Plug 'fatih/vim-go'
Plug 'osyo-manga/vim-brightest'
Plug 'Shougo/junkfile.vim'
Plug 'kien/ctrlp.vim'
Plug 'junegunn/fzf', {'dir': '~/.fzf', 'do': './install --bin'}
Plug 'junegunn/fzf.vim'
call plug#end()
" }}} junegunn/vim-plug

" {{{ scrooloose/nerdcommenter
let g:NERDCreateDefaultMappings=0
let g:NERDSpaceDelims=1
let g:NERDTrimTrailingWhitespace=1
let g:NERDCustomDelimiters = {
            \ 'hcl': {'left': '#'},
            \ }

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
highlight BrightestDark ctermbg=237
let g:brightest#highlight={"group": "BrightestDark"}
let g:brightest#enable_on_CursorHold=1
let g:brightest#enable_highlight_all_window=1
" }}} osyo-match/vim-brightest

" {{{ Shougo/junkfile.vim
nnoremap <Leader>jf :JunkfileOpen<CR>
" }}} Shougo/junkfile.vim

" {{{ kien/ctrlp.vim
let g:ctrlp_map='<Nop>'
let g:ctrlp_working_path_mode='c'
let g:ctrlp_match_window='bottom,order:btt,min:1,max:20,results:100'
let g:ctrlp_open_new_file='r'
let g:ctrlp_lazy_update=1

if executable("ag")
  let g:ctrlp_use_cacheing=0
  let g:ctrlp_user_command='ag %s -i --nocolor --nogroup -g ""'
endif

nnoremap <silent> <Space>b :CtrlPBuffer<CR>
nnoremap <silent> <Space><Space> :CtrlPMRU<CR>
nnoremap <silent> <Space>f :CtrlP<CR>

set splitright
set splitbelow
" }}} kien/ctrlp.vim

command! -bang -nargs=* Ag
            \ call fzf#vim#ag(<q-args>,
                \ fzf#vim#with_preview({'options': '--exact'}, 'right:50%:wrap'),
                \ 0)

" vim: foldmethod=marker
" vim: foldmarker={{{,}}}
