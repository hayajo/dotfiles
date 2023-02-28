set autoindent
set backspace=2
set clipboard=unnamed
set completeopt=menuone
set cursorline
set display=lastline
set expandtab
set hidden
set ignorecase
set incsearch
set list
" set listchars=tab:»\ ,extends:›,precedes:‹,nbsp:·,trail:·
set listchars=tab:>\ ,trail:~,extends:>,precedes:<,nbsp:%
set matchtime=1
set nocompatible
set noswapfile
set number
set pumheight=10
" set scrolloff=999 " always keep the cursor centered. fzf_layoutのwindowと相性が悪いので注意.
set shiftwidth=4
set showmatch
set smartcase
set softtabstop=4
set tabstop=4
set updatetime=300
set wildmenu
set wildmode=longest:full,full
" set spelllang=en,cjk
set ambiwidth=double

" let mapleader=","
let mapleader="\<Space>"

nmap \E :vsplit<CR>:e %:p:h<CR>
nmap \e :e %:p:h<CR>
nmap \n :set number!<CR>
nmap \i :IndentGuidesToggle<CR>
" nmap \s :set spell!<CR>
nmap \s <Plug>(spelunker-toggle)
nmap \w :set wrap!<CR>
nmap \x :cclose<CR>

map ; :

nnoremap + <C-a>
nnoremap - <C-x>
nnoremap Y y$

" Emacs-like keybinds in inert mode
inoremap <C-p> <Up>
inoremap <C-n> <Down>
inoremap <C-f> <Right>
inoremap <C-b> <Left>
inoremap ƒ <C-Right> " <Alt-f>
inoremap ∫ <C-Left> " <Alt-b>
inoremap <C-a> <Home>
inoremap <C-e> <End>
inoremap <C-d> <Del>
inoremap <C-h> <BS>
inoremap <C-k> <C-o>C

" Emacs-like keybinds in command-line mode
cnoremap <C-p> <Up>
cnoremap <C-n> <Down>
cnoremap <C-f> <Right>
cnoremap <C-b> <Left>
cnoremap <C-a> <Home>
cnoremap <C-e> <End>
cnoremap <C-d> <Del>
cnoremap <C-h> <BS>
cnoremap <C-k> <C-\>estrpart(getcmdline(), 0, getcmdpos()-1)<CR>

nmap <Leader>bd :bdelete<CR>

if has("autocmd")
  "ファイルタイプの検索を有効にする
  filetype plugin on
  "ファイルタイプに合わせたインデントを利用
  filetype indent on
  "sw=shiftwidth, sts=softtabstop, ts=tabstop, et=expandtabの略
  " autocmd FileType c           setlocal sw=4 sts=4 ts=4 et
  " autocmd FileType html        setlocal sw=4 sts=4 ts=4 et
  " autocmd FileType ruby        setlocal sw=2 sts=2 ts=2 et
  " autocmd FileType js          setlocal sw=4 sts=4 ts=4 et
  " autocmd FileType zsh         setlocal sw=4 sts=4 ts=4 et
  " autocmd FileType python      setlocal sw=4 sts=4 ts=4 et
  " autocmd FileType scala       setlocal sw=4 sts=4 ts=4 et
  " autocmd FileType json        setlocal sw=4 sts=4 ts=4 et
  " autocmd FileType html        setlocal sw=4 sts=4 ts=4 et
  " autocmd FileType css         setlocal sw=4 sts=4 ts=4 et
  " autocmd FileType scss        setlocal sw=4 sts=4 ts=4 et
  " autocmd FileType sass        setlocal sw=4 sts=4 ts=4 et
  autocmd FileType typescript  setlocal sw=2 sts=2 ts=2 et
endif


" {{{ netrw
let g:netrw_alto=1
let g:netrw_altv=1
let g:netrw_keepdir=0
let g:netrw_special_syntax= 1
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
" Plug 'h1mesuke/vim-alignta'
Plug 'maralla/completor.vim'
Plug 'tpope/vim-fugitive'
Plug 'derekwyatt/vim-scala'
Plug 'leafgarland/typescript-vim'
Plug 'haya14busa/incsearch.vim'
Plug 'jiangmiao/auto-pairs'
Plug 'tpope/vim-unimpaired'
Plug 'cocopon/iceberg.vim'
Plug 'airblade/vim-gitgutter'
Plug 'kamykn/spelunker.vim'
Plug 'nathanaelkane/vim-indent-guides'
Plug 'tomasiser/vim-code-dark'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'dense-analysis/ale'
" Plug 'fszymanski/fzf-quickfix', {'on': 'Quickfix'}
Plug 'andymass/vim-matchup'
Plug 'terryma/vim-expand-region'
Plug 'tpope/vim-rhubarb'
Plug 'skanehira/translate.vim'
Plug 'junegunn/vim-easy-align'
Plug 'LeafCage/yankround.vim'
Plug 'leafgarland/typescript-vim'
Plug 'chr4/nginx.vim'
Plug 'hashivim/vim-terraform'
Plug 'easymotion/vim-easymotion'
Plug 'google/vim-jsonnet'
" Plug 'mattn/vim-chatgpt'
call plug#end()
" }}} junegunn/vim-plug

" {{{ color
" Use true colors
" see. https://vim-jp.org/vimdoc-ja/term.html#xterm-true-color
let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
set termguicolors

" colorscheme iceberg
let g:codedark_transparent=1
let g:airline_theme = 'codedark'
colorscheme codedark
highlight clear Cursorline
highlight CursorLine gui=underline cterm=underline
" }}} color

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
" let g:go_highlight_types = 1
" let g:go_highlight_fields = 1
" let g:go_highlight_function_calls = 1
" let g:go_highlight_operators = 1
" let g:go_highlight_extra_types = 1
let g:go_highlight_build_constraints = 1
let g:go_highlight_generate_tags = 1

let g:go_fmt_command="goimports"
let g:go_auto_type_info=1
let g:go_metalinter_autosave=1
let g:go_list_type = "quickfix"

autocmd FileType go :highlight goErr cterm=bold ctermfg=214
autocmd FileType go :match goErr /\<err\>/
autocmd FileType go nmap <Leader>gc <Plug>(go-coverage-toggle)
autocmd FileType go nmap <Leader>gi :GoImport 
autocmd FileType go nmap <Leader>gl :GoLint<CR>
autocmd FileType go nmap <Leader>gb <Plug>(go-build)
autocmd FileType go nmap <Leader>gr <Plug>(go-run)
autocmd FileType go nmap <Leader>gs <Plug>(go-def-split)
autocmd FileType go nmap <Leader>gt <Plug>(go-test)
autocmd FileType go nmap <Leader>gv <Plug>(go-def-vertical)
autocmd FileType go nmap gp :GoDefPop<CR>
" }}} fatih/vim-go

" {{{ osyo-match/vim-brightest
" let g:brightest#highlight={"group": "BrightestUnderline"}
let g:brightest#highlight={"group": "BrightestReverse"}
let g:brightest#enable_on_CursorHold=1
" let g:brightest#enable_highlight_all_window=1
let g:brightest#enable_highlight_all_window=0
" }}} osyo-match/vim-brightest

" {{{ Shougo/junkfile.vim
" nnoremap <Leader><Space> :JunkfileOpen<CR>
" }}} Shougo/junkfile.vim

" {{{ junegunn/fzf
" nnoremap <silent> <Space><Space> :History<CR>
" nnoremap <silent> <Space>a :Ag<CR>
" nnoremap <silent> <Space>b :Buffers<CR>
" nnoremap <silent> <Space>d :BD<CR>
" nnoremap <silent> <Space>f :DFiles<CR>
" nnoremap <silent> <Space>g :GGrep<CR>
" nnoremap <silent> <Space>m :Marks<CR>
" nnoremap <silent> <Space>r :Ghq<CR>
" nnoremap <silent> <Space>q :Quickfix<CR>
" nnoremap <silent> <C-p> :GFiles<CR>
nnoremap <silent> <c-x><c-x> :History<CR>
nnoremap <silent> <c-x><c-a> :Ag<CR>
nnoremap <silent> <c-x><c-b> :Buffers<CR>
nnoremap <silent> <c-x><c-d> :BD<CR>
nnoremap <silent> <c-x><c-f> :DFiles<CR>
nnoremap <silent> <c-x><c-g> :GGrep<CR>
nnoremap <silent> <c-x><c-m> :Marks<CR>
nnoremap <silent> <c-x><c-r> :Ghq<CR>
" nnoremap <silent> <c-x><c-q> :Quickfix<CR>
nnoremap <silent> <c-x><C-p> :GFiles<CR>

set splitright
set splitbelow

" let $FZF_DEFAULT_OPTS = '--reverse'

let g:fzf_layout = { 'window': { 'width': 0.9, 'height': 0.6, 'highlight': 'Comment' } }

command! -bang -nargs=* Ag call fzf#vim#ag(
            \ <q-args>,
            \ fzf#vim#with_preview({'options': '--exact --delimiter : --nth 3..'}),
            \ 0
            \ )
command! -bang -nargs=* GGrep call fzf#vim#grep(
            \ 'git grep --line-number '.shellescape(<q-args>),
            \ 0,
            \ fzf#vim#with_preview({'dir': systemlist('git rev-parse --show-toplevel')[0], 'options': '--exact --delimiter : --nth 3..'}),
            \ <bang>0
            \ )

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
                \ 'e'
                \ )
    if isdirectory(s:fzf_dfiles_sink_path) && cmd == 'e'
        call fzf#run(fzf#wrap({
                    \ 'source': 'ls -ap1 ' . s:fzf_dfiles_sink_path . ' | tail -n +2',
                    \ 'sink*': function('s:fzf_dfiles_sink'),
                    \ 'options': '-x +s --expect=ctrl-t,ctrl-v,ctrl-x --prompt=' . fnamemodify(s:fzf_dfiles_sink_path, ":~")
                    \ }))
    else
        execute cmd s:fzf_dfiles_sink_path
    endif
endfunction

" Ghq
command! Ghq call s:fzf_ghq_sink()
function! s:fzf_ghq_sink(...)
    call fzf#run(fzf#wrap({
                \ 'source': 'ghq list -p',
                \ 'sink': 'e'
                \ }))
endfunction

" BD (delete buffers)
" https://github.com/junegunn/fzf.vim/pull/733#issuecomment-559720813
command! BD call fzf#run(fzf#wrap({
  \ 'source': s:list_buffers(),
  \ 'sink*': { lines -> s:delete_buffers(lines) },
  \ 'options': '--multi --bind ctrl-a:select-all'
\ }))
function! s:list_buffers()
  redir => list
  silent ls
  redir END
  return split(list, "\n")
endfunction
function! s:delete_buffers(lines)
  execute 'bwipeout' join(map(a:lines, {_, line -> split(line)[0]}))
endfunction
" }}} junegunn/fzf

" {{{ maralla/completor.vim
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <expr> <cr> pumvisible() ? "\<C-y>\<CR>" : "\<CR>"
" }}} maralla/completor.vim

" {{{ haya14busa/incsearch.vim
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
map /  <Plug>(incsearch-forward)
map ?  <Plug>(incsearch-backward)
" }}} haya14busa/incsearch.vim

" {{{ vim-airline/vim-airline
let g:airline#extensions#tabline#enabled = 1
" }}} vim-airline/vim-airline

" {{{ dense-analysis/ale
let g:ale_set_loclist = 0
let g:ale_set_quickfix = 1
let g:ale_linters = {
\   'markdown': ['markdownlint', 'textlint'],
\   'dockerfile': ['hadolint'],
\}
" }}} dense-analysis/ale

" {{{ airblade/vim-gitgutter
nmap ]h <Plug>(GitGutterNextHunk)<Plug>(GitGutterPreviewHunk)
nmap [h <Plug>(GitGutterPrevHunk)<Plug>(GitGutterPreviewHunk)

" カーソルがhunkに移動したときに変更をプレビューする
" au CursorMoved * if exists('*gitgutter#utility#is_active') && gitgutter#utility#is_active(bufnr('')) |
    " \   if gitgutter#hunk#in_hunk(line('.')) |
    " \       if getwinvar(winnr("#"), "&pvw") == 0 |
    " \           call gitgutter#hunk#preview() |
    " \       endif |
    " \   else |
    " \       pclose |
    " \   endif |
    " \ endif
" }}} airblade/vim-gitgutter


" {{{ terryma/vim-expand-region
vmap v <Plug>(expand_region_expand)
vmap <C-v> <Plug>(expand_region_shrink)
" }}} terryma/vim-expand-region

" {{{ LeafCage/yankround.vim
nmap p <Plug>(yankround-p)
nmap P <Plug>(yankround-P)
nmap <C-p> <Plug>(yankround-prev)
nmap <C-n> <Plug>(yankround-next)
let g:yankround_max_history = 50
" }}} LeafCage/yankround.vim

source $VIMRUNTIME/macros/matchit.vim

au FileType yaml :IndentGuidesEnable
au FileType yaml,js,javascript,json,html,xml,markdown setlocal ts=2 sts=2 sw=2 expandtab

let g:github_enterprise_urls = ['https://ghe.admin.h']

map <Leader> <Plug>(easymotion-prefix)

" <Leader>f{char} to move to {char}
map  <Leader>f <Plug>(easymotion-bd-f)
nmap <Leader>f <Plug>(easymotion-overwin-f)

" s{char}{char} to move to {char}{char}
nmap s <Plug>(easymotion-overwin-f2)

" Move to line
map <Leader>L <Plug>(easymotion-bd-jk)
nmap <Leader>L <Plug>(easymotion-overwin-line)

" Move to word
map  <Leader>w <Plug>(easymotion-bd-w)
nmap <Leader>w <Plug>(easymotion-overwin-w)

map  / <Plug>(easymotion-sn)
omap / <Plug>(easymotion-tn)
map  n <Plug>(easymotion-next)
map  N <Plug>(easymotion-prev)


" vim: foldmethod=marker
" vim: foldmarker={{{,}}}
