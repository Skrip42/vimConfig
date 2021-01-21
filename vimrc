"----------------------------------------------------------------------------------------------------
"plugins
"----------------------------------------------------------------------------------------------------
call plug#begin('~/.bim/plugged')

"colorschem
Plug 'Skrip42/angr.vim'
"dir exploration
Plug 'preservim/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
"commenter
Plug 'Tomtom/tcomment_vim'
"fzf and grep alternative
Plug 'liuchengxu/vim-clap'
Plug 'liuchengxu/vim-clap', { 'on': 'Clap', 'do': ':Clap install-binary' }
"coc-base server
Plug 'neoclide/coc.nvim', {'branch': 'release'}
"tabnine
Plug 'neoclide/coc-tabnine', {'do': 'yarn install --frozen-lockfile'}
"language servers
Plug 'neoclide/coc-json',            { 'do': 'yarn install --frozen-lockfile'}
Plug 'josa42/coc-go',                { 'do': 'yarn install --frozen-lockfile'}
Plug 'neoclide/coc-html',            { 'do': 'yarn install --frozen-lockfile'}
Plug 'neoclide/coc-css',             { 'do': 'yarn install --frozen-lockfile'}
Plug 'neoclide/coc-tsserver',        { 'do': 'yarn install --frozen-lockfile'}
Plug 'voldikss/coc-cmake',           { 'do': 'yarn install --frozen-lockfile'}
Plug 'josa42/coc-sh',                { 'do': 'yarn install --frozen-lockfile'}
Plug 'neoclide/coc-yaml',            { 'do': 'yarn install --frozen-lockfile'}
Plug 'fannheyward/coc-xml',          { 'do': 'yarn install --frozen-lockfile'}
Plug 'iamcco/coc-vimlsp',            { 'do': 'yarn install --frozen-lockfile'}
Plug 'iamcco/coc-svg',               { 'do': 'yarn install --frozen-lockfile'}
Plug 'fannheyward/coc-markdownlint', { 'do': 'yarn install --frozen-lockfile'}
Plug 'marlonfan/coc-phpls',          { 'do': 'yarn install --frozen-lockfile'}
"snippets
Plug 'neoclide/coc-snippets', {'do': 'yarn install --frozen-lockfile'}
Plug 'honza/vim-snippets'
"linter
Plug 'vim-syntastic/syntastic'
"tot tabline
Plug 'ap/vim-buftabline'
"bottom statusline
Plug 'itchyny/lightline.vim'
"git integration
Plug 'tpope/vim-fugitive'
Plug 'mhinz/vim-signify'
"tmux integration
Plug 'christoomey/vim-tmux-navigator'
"twig fix
Plug 'nelsyeung/twig.vim'
"surround
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
"alignment
Plug 'junegunn/vim-easy-align'
"templator
Plug 'skrip42/vim-templator'

call plug#end()

"----------------------------------------------------------------------------------------------------
"base
"----------------------------------------------------------------------------------------------------
set number
set incsearch
set hlsearch
set termencoding=utf8
syntax on
set updatetime=100
set signcolumn=yes
set mouse=a
set wildmenu
set wildmode=full
set history=200
set cmdheight=2

set hidden

if has("syntax") "//enable syntax
  syntax on
endif

set spelllang=ru,en "//enable ru spell
set clipboard=unnamedplus "//clipboard recompile vim witch x11 to enabled this
let mapleader = "\\" "//change leader key

"----------------------------------------------------------------------------------------------------
"foldings
"----------------------------------------------------------------------------------------------------
set foldenable
set foldmethod=marker
set foldcolumn=0
set foldlevel=5
set foldopen=mark,quickfix,search,tag,undo
let php_folding=2

autocmd InsertEnter * let w:last_fdm=&foldmethod | setlocal foldmethod=manual
autocmd InsertLeave * let &l:foldmethod=w:last_fdm

"----------------------------------------------------------------------------------------------------
"ofsets
"----------------------------------------------------------------------------------------------------
set expandtab
set tabstop=4
set shiftwidth=4
set softtabstop=4

"disable backup to corect coc worcking
set nobackup
set nowritebackup

"set smarttab
"set smartindent
"set autoindent

"----------------------------------------------------------------------------------------------------
"disabling swapfile
"----------------------------------------------------------------------------------------------------
set backupdir=~/.vimbackup
set directory=~/.vimswap
set undodir=~/.vimundo

if filereadable("/etc/vim/vimrc.local")
  source /etc/vim/vimrc.local
endif

"----------------------------------------------------------------------------------------------------
"kirilica
"----------------------------------------------------------------------------------------------------
set langmap=йцукенгшщзфывапролдячсмитьЙЦУКЕНГШЩЗФЫВАПРОЛДЯЧСМИТЬ;qwertyuiopasdfghjklzxcvbnmQWERTYUIOPASDFGHJKLZXCVBNM
set keymap=russian-jcukenwin
set iminsert=0
set imsearch=0
highlight lCursor ctermfg=cyan

"----------------------------------------------------------------------------------------------------
"autosave worckflow
"----------------------------------------------------------------------------------------------------
augroup AutoSaveFolds
  autocmd!
  " view files are about 500 bytes
  " bufleave but not bufwinleave captures closing 2nd tab
  " nested is needed by bufwrite* (if triggered via other autocmd)
  autocmd BufWinLeave,BufLeave,BufWritePost ?* nested silent! mkview!
  autocmd BufWinEnter ?* silent! loadview
augroup end

"----------------------------------------------------------------------------------------------------
"toggle lest status
"----------------------------------------------------------------------------------------------------
let g:toggleStatus=1
set listchars=tab:▸\ ,eol:¬
function LeftStatusToggle()
    if g:toggleStatus == 1
        "set foldcolumn=0
        set nonumber
        set signcolumn=no
        let g:toggleStatus = 0
    else
        "set foldcolumn=2
        set number
        set signcolumn=yes
        let g:toggleStatus = 1
    endif
endfunction

nmap <F3> :call LeftStatusToggle()<CR>
nmap <F2> :set invlist<CR>

"----------------------------------------------------------------------------------------------------
"colorscheme
"----------------------------------------------------------------------------------------------------
set termguicolors
colorscheme angr

"----------------------------------------------------------------------------------------------------
"remove trailing whitespace
"----------------------------------------------------------------------------------------------------
autocmd BufWritePre * %s/\s\+$//e

"----------------------------------------------------------------------------------------------------
"navigation settings
"----------------------------------------------------------------------------------------------------
"nerdtree call:
noremap <Leader>e :e . <CR>
noremap <Leader>v :vsp . <CR>
noremap <Leader>s :sp . <CR>
noremap <Leader>f :Clap files <CR>
noremap <Leader>a :Clap grep <CR>

"----------------------------------------------------------------------------------------------------
"nert tree plugin config
"----------------------------------------------------------------------------------------------------
let g:NERDTreeChDirMode = 2
let g:NERDTreeQuitOnOpen = 1

"----------------------------------------------------------------------------------------------------
"clap plugin config
"----------------------------------------------------------------------------------------------------
"let g:clap_theme = { 'display': {'ctermbg': '235', 'guibg': '#272d3D'} }

"----------------------------------------------------------------------------------------------------
"coc plugin config
"----------------------------------------------------------------------------------------------------
" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
" diagnostic navigation
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

nmap <silent> [f  <Plug>(coc-fix-current)


"----------------------------------------------------------------------------------------------------
"syntastic plugin config
"----------------------------------------------------------------------------------------------------
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 0
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 1

"let g:syntastic_php_checkers = ['php', 'phpcs'] "uncoment this to disable phpcs and phpmb
let g:syntastic_php_phpcs_args='--standard=PSR2 -n'

"----------------------------------------------------------------------------------------------------
"tcomment plugin config
"----------------------------------------------------------------------------------------------------
" let g:tcomment_maps = 0
" nmap <c-_> :TComment<CR>
" vmap <c-_> :'<,'>TCommentInline<CR>


"----------------------------------------------------------------------------------------------------
"lightline plugin config
"----------------------------------------------------------------------------------------------------
set laststatus=2
let g:lightline = {
      \ 'colorscheme': 'wombat',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'gitbranch', 'readonly', 'filename', 'modified' ] ],
      \   'right': [ ['lineinfo', 'percent'],
      \              ['coc_error', 'coc_warning', 'coc_hint', 'coc_info'],
      \              ['fileformat', 'fileencoding', 'filetype', 'charvaluehex'] ]
      \ },
      \ 'component_function': {
      \   'gitbranch': 'FugitiveHead'
      \ },
      \ 'component_expand': {
      \   'coc_error'        : 'LightlineCocErrors',
      \   'coc_warning'      : 'LightlineCocWarnings',
      \   'coc_info'         : 'LightlineCocInfos',
      \   'coc_hint'         : 'LightlineCocHints',
      \   'coc_fix'          : 'LightlineCocFixes',
      \ },
      \ 'component_type': {
      \   'coc_error'        : 'error',
      \   'coc_warning'      : 'warning',
      \   'coc_info'         : 'tabsel',
      \   'coc_hint'         : 'tabsel',
      \   'coc_fix'          : 'tabsel',
      \ }
      \ }

function! s:lightline_coc_diagnostic(kind) abort
  let info = get(b:, 'coc_diagnostic_info', 0)
  if empty(info) || get(info, a:kind, 0) == 0
    return ''
  endif
   return printf('%s: %d', a:kind, info[a:kind])
  "return printf('%d', info[a:kind])
endfunction

function! LightlineCocErrors() abort
  return s:lightline_coc_diagnostic('error')
endfunction

function! LightlineCocWarnings() abort
  return s:lightline_coc_diagnostic('warning')
endfunction

function! LightlineCocInfos() abort
  return s:lightline_coc_diagnostic('information')
endfunction

function! LightlineCocHints() abort
  return s:lightline_coc_diagnostic('hint')
endfunction

autocmd User CocDiagnosticChange call lightline#update()

"----------------------------------------------------------------------------------------------------
"fugitive plugin config
"----------------------------------------------------------------------------------------------------
nmap <F4> :Gblame<CR>
nmap <F5> :Gdiffsplit<CR>

"----------------------------------------------------------------------------------------------------
"bugtabline plugin config
"----------------------------------------------------------------------------------------------------
nnoremap <C-N> :bnext<CR>
nnoremap <C-P> :bprev<CR>

"----------------------------------------------------------------------------------------------------
"coc-snippets plugin config
"----------------------------------------------------------------------------------------------------
imap <C-l> <Plug>(coc-snippets-expand)
vmap <C-j> <Plug>(coc-snippets-select)

inoremap <silent><expr> <TAB>
      \ pumvisible() ? coc#_select_confirm() :
      \ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

let g:coc_snippet_next = '<tab>'

"----------------------------------------------------------------------------------------------------
"easy-align plugin config
"----------------------------------------------------------------------------------------------------
nmap ga <Plug>(EasyAlign)
xmap ga <Plug>(EasyAlign)

"----------------------------------------------------------------------------------------------------
"templator plugin config
"----------------------------------------------------------------------------------------------------
" let g:templator_ingnore_priority = 1
" let g:templator_autotemplate = 0
