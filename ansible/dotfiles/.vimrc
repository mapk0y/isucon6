" vim: set ts=2 sw=2 sts=0:
set ts=2 sw=2 sts=0
set background=dark
let mapleader = ','
scriptencoding utf-8

set fileformats=unix,dos,mac
if exists('&ambiwidth')
    set ambiwidth=double
endif

set autoindent
"バイナリ編集(xxd)モード（vim -b での起動、もしくは *.bin で発動します）
augroup BinaryXXD
    autocmd!
    autocmd BufReadPre  *.bin let &binary =1
    autocmd BufReadPost * if &binary | silent %!xxd -g 1
    autocmd BufReadPost * set ft=xxd | endif
    autocmd BufWritePre * if &binary | %!xxd -r | endif
    autocmd BufWritePost * if &binary | silent %!xxd -g 1
    autocmd BufWritePost * set nomod | endif
augroup END

set ignorecase
set smartcase
set wrapscan
set noincsearch
set wildmode=list:longest

syntax on
set number
set list
set tabstop=4
set shiftwidth=4
set showmatch
set hlsearch
set laststatus=2

"-----------------------------------------------------------------------------
" map
nmap <ESC><ESC> :nohlsearch<CR><ESC>
cnoremap <C-A> <HOME>
nnoremap <silent> j gj
nnoremap <silent> k gk
inoremap <silent> jj <ESC>
inoremap <silent> kk <ESC>
inoremap <silent> <C-j> <Down>
inoremap <silent> <C-k> <Up>
inoremap <silent> <C-e> <End>

"-----------------------------------------------------------------------------
highlight WhitespaceEOL ctermbg=red guibg=red
match WhitespaceEOL /\s\+$/
autocmd WinEnter * match WhitespaceEOL /\s\+$/

set backup
set backupdir=$HOME/.vim-backup
let &directory = &backupdir

set diffexpr=IgnoreSpaceDiff()
function! IgnoreSpaceDiff()
    let opt = ""
    if &diffopt =~ "icase"
        let opt = opt . "-i "
    endif
    if &diffopt =~ "iwhite"
        let opt = opt . "-b "
    endif
    silent execute "!diff --ignore-all-space -a " . opt .
          \  v:fname_in . " " . v:fname_new .
          \  " > " . v:fname_out
endfunction

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" etc
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" https://gist.github.com/rbtnn/8540338
augroup auto_comment_off
    autocmd!
    " help add-option-flags
    autocmd BufEnter * setlocal formatoptions-=r
    autocmd BufEnter * setlocal formatoptions-=o
augroup END

" 位置の保存
augroup vimrcEx
    au BufRead * if line("'\"") > 0 && line("'\"") <= line("$") |
    \ exe "normal g`\"" | endif
augroup END

" folding
let g:vimsyn_folding = 'afP'
" BS to EOL
set backspace=indent,eol,start
set expandtab
set visualbell t_vb=
set t_Co=256
set mouse=
set listchars=tab:»-,extends:»,precedes:«,nbsp:%
