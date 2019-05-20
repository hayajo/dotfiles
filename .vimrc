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
set listchars=tab:»\ ,extends:›,precedes:‹,nbsp:·,trail:·
set matchtime=1
set nocompatible
set noswapfile
set number
set pumheight=10
set scrolloff=999 " always keep the cursor centered
set shiftwidth=4
set showmatch
set smartcase
set softtabstop=4
set tabstop=4
set updatetime=300
set wildmode=list,full

let mapleader=","

nmap \E :vsplit<CR>:e %:p:h<CR>
nmap \e :e %:p:h<CR>
nmap \r :RainbowLevelsToggle<CR>
nmap \s :set spell!<CR>
nmap \w :set wrap!<CR>
nmap \x :cclose<CR>

map ; :

nnoremap + <C-a>
nnoremap - <C-x>
nnoremap Y y$

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
Plug 'h1mesuke/vim-alignta'
Plug 'maralla/completor.vim'
Plug 'tpope/vim-fugitive'
Plug 'derekwyatt/vim-scala'
Plug 'leafgarland/typescript-vim'
Plug 'haya14busa/incsearch.vim'
Plug 'thiagoalessio/rainbow_levels.vim'
Plug 'jiangmiao/auto-pairs'
Plug 'tpope/vim-unimpaired'
Plug 'cocopon/iceberg.vim'
call plug#end()
" }}} junegunn/vim-plug

" {{{ color
" Use true colors
" see. https://vim-jp.org/vimdoc-ja/term.html#xterm-true-color
let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
set termguicolors

colorscheme iceberg
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
autocmd FileType go nmap <Leader>gi :GoImport 
autocmd FileType go nmap <Leader>gl :GoLint<CR>
autocmd FileType go nmap <leader>gr <Plug>(go-run)
autocmd FileType go nmap <leader>gb <Plug>(go-build)
autocmd FileType go nmap <leader>gt <Plug>(go-test)
autocmd FileType go nmap <Leader>gc <Plug>(go-coverage-toggle)
autocmd FileType go nmap gp :GoDefPop<CR>
" }}} fatih/vim-go

" {{{ osyo-match/vim-brightest
let g:brightest#highlight={"group": "BrightestUnderline"}
let g:brightest#enable_on_CursorHold=1
let g:brightest#enable_highlight_all_window=1
" }}} osyo-match/vim-brightest

" {{{ Shougo/junkfile.vim
nnoremap <Leader>jf :JunkfileOpen<CR>
" }}} Shougo/junkfile.vim

" {{{ junegunn/fzf
nnoremap <silent> <Space><Space> :History<CR>
nnoremap <silent> <Space>a :Ag<CR>
nnoremap <silent> <Space>b :Buffers<CR>
nnoremap <silent> <Space>f :DFiles<CR>
nnoremap <silent> <Space>g :GGrep<CR>
nnoremap <silent> <Space>m :Marks<CR>
nnoremap <silent> <Space>r :Repos<CR>
nnoremap <silent> <C-p> :GFiles<CR>

set splitright
set splitbelow

command! -bang -nargs=* Ag call fzf#vim#ag(
            \ <q-args>,
            \ fzf#vim#with_preview({'options': '--exact --delimiter : --nth 3..'}, 'right:50%:wrap'),
            \ 0
            \ )
command! -bang -nargs=* GGrep call fzf#vim#grep(
            \ 'git grep --line-number '.shellescape(<q-args>),
            \ 0,
            \ fzf#vim#with_preview({'dir': systemlist('git rev-parse --show-toplevel')[0], 'options': '--exact --delimiter : --nth 3..'}, 'right:50%:wrap'),
            \ <bang>0
            \ )
"
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
        call fzf#run({
                    \ 'source': 'ls -ap1 ' . s:fzf_dfiles_sink_path . ' | tail -n +2',
                    \ 'sink*': function('s:fzf_dfiles_sink'),
                    \ 'options': '-x +s --expect=ctrl-t,ctrl-v,ctrl-x --prompt=' . fnamemodify(s:fzf_dfiles_sink_path, ":~"),
                    \ 'down': '40%'
                    \ })
    else
        execute cmd s:fzf_dfiles_sink_path
    endif
endfunction

" Repos
command! Repos call s:fzf_repos_sink()

function! s:fzf_repos_sink(...)
    call fzf#run({
                \ 'source': 'ghq list -p',
                \ 'sink': 'e',
                \ 'down': '40%'
                \ })
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

source $VIMRUNTIME/macros/matchit.vim

" vim: foldmethod=marker
" vim: foldmarker={{{,}}}
