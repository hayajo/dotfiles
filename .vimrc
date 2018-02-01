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
set hlsearch
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
set completeopt=menuone

let mapleader=","

nnoremap Y y$
nnoremap + <C-a>
nnoremap - <C-x>

" {{{ color
set background=dark
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
Plug 'junegunn/fzf', {'dir': '~/.fzf', 'do': './install --bin'}
Plug 'junegunn/fzf.vim'
Plug 'h1mesuke/vim-alignta'
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

" {{{ junegunn/fzf
nnoremap <silent> <Space><Space> :History<CR>
nnoremap <silent> <Space>b :Buffers<CR>
nnoremap <silent> <Space>f :DFiles<CR>
nnoremap <silent> <C-p> :GFiles<CR>
set splitright
set splitbelow

command! -bang -nargs=* Ag call fzf#vim#ag(
            \ <q-args>,
            \ fzf#vim#with_preview({'options': '--exact --delimiter : --nth 3..'}, 'right:50%:wrap'),
            \ 0)

" DFiles
command! DFiles call s:fzf_dfiles_sink()

let s:fzf_dfiles_sink_path = ''
function! s:fzf_dfiles_sink(...)
    let file = get(a:000, 0, ['', '.'])
    if len(file) < 2 | return | endif
    let s:fzf_dfiles_sink_path = fnamemodify(len(a:000) ? s:fzf_dfiles_sink_path . file[1] : file[1], ':p')
    let cmd = get(
                \ {'ctrl-x': 'split', 'ctrl-v': 'vertical split', 'ctrl-t': 'tabe'},
                \ file[0],
                \ 'e')
    if isdirectory(s:fzf_dfiles_sink_path) && cmd == 'e'
        call fzf#run({
                    \ 'source': 'ls -ap1 ' . s:fzf_dfiles_sink_path . ' | tail -n +2',
                    \ 'sink*': function('s:fzf_dfiles_sink'),
                    \ 'options': '-x +s --expect=ctrl-t,ctrl-v,ctrl-x --prompt=' . fnamemodify(s:fzf_dfiles_sink_path, ":~"),
                    \ 'down': '40%'})
    else
        execute cmd s:fzf_dfiles_sink_path
    endif
endfunction
" }}} junegunn/fzf

" vim: foldmethod=marker
" vim: foldmarker={{{,}}}
