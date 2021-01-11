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
Plug 'scrooloose/nerdcommenter'
"snippets
"Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'
Plug 'honza/vim-snippets'
"fzf and grep alternative
Plug 'liuchengxu/vim-clap'
Plug 'liuchengxu/vim-clap', { 'on': 'Clap', 'do': ':Clap install-binary' }
"language server
Plug 'neoclide/coc.nvim', {'branch': 'release'}
"linter
Plug 'vim-syntastic/syntastic'
"buffers
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
"nerd commenter plugin config
"----------------------------------------------------------------------------------------------------
map <C-_> <plug>NERDCommenterToggle

"----------------------------------------------------------------------------------------------------
"coc plugin config
"----------------------------------------------------------------------------------------------------
" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

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
"lightline plugin config
"----------------------------------------------------------------------------------------------------
set laststatus=2
let g:lightline = {
      \ 'colorscheme': 'wombat',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'gitbranch', 'readonly', 'filename', 'modified' ] ]
      \ },
      \ 'component_function': {
      \   'gitbranch': 'FugitiveHead'
      \ },
      \ }

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
"vim template plugin config
"----------------------------------------------------------------------------------------------------
"autocmd BufRead *.* if getfsize(expand('%'))==0| :Template

"----------------------------------------------------------------------------------------------------
"coc-snippets plugin config
"----------------------------------------------------------------------------------------------------
imap <C-l> <Plug>(coc-snippets-expand)
vmap <C-j> <Plug>(coc-snippets-select)
