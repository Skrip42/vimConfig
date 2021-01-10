"----------------------------------------------------------------------------------------------------
"plugins
"----------------------------------------------------------------------------------------------------
call plug#begin('~/.bim/plugged')

"colorschem
Plug 'Skrip42/angr.vim'
"nerdtree
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
"nertcommenter
Plug 'scrooloose/nerdcommenter'
"ultisnips
Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'
"clap
Plug 'liuchengxu/vim-clap'
Plug 'liuchengxu/vim-clap', { 'do': ':Clap install-binary' }
"coc
Plug 'neoclide/coc.nvim', {'branch': 'release'}
"lightline
Plug 'itchyny/lightline.vim'

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
"ultisnips plugin config
"----------------------------------------------------------------------------------------------------
let g:UltiSnipsExpandTrigger = "<tab>"
let g:UltiSnipsJumpForwardTrigger = "<c-j>"
let g:UltiSnipsJumpBackwardTrigger = "<s-tab>"
set runtimepath+=~/.vim/UltiSnips
let g:UltiSnipaSnippetDirectories=["~/.vim/UltiSnips"]

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
"lightline plugin config
"----------------------------------------------------------------------------------------------------
set laststatus=2
