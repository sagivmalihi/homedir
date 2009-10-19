set nocompatible
behave mswin

source $VIMRUNTIME/mswin.vim
source $HOME/.vim/cscope_maps.vim
source $HOME/.vim/python_fn.vim

set selection=inclusive

"search options
set ignorecase
set smartcase
set incsearch
set hlsearch

set wildignore=*.o,*.obj,*.bak,*.exe,*.pyc,*.pyo,*~

"black colorscheme
colorscheme torte
syntax on 

set backspace=eol,start,indent

"proper tab handling (insert spaces)
set tabstop=4
set shiftwidth=4
set expandtab
set softtabstop=4
set autoindent
set smarttab

"mouse always enabled (also in terminal)
set mouse=a

"proper autocomplete
set completeopt=longest,menuone
inoremap <expr> <cr> pumvisible() ? "\<c-y>" : "\<c-g>u\<cr>"
 :inoremap <expr> <c-n> pumvisible() ? "\<lt>c-n>" : "\<lt>c-n>\<lt>c-r>=pumvisible() ? \"\\<lt>down>\" : \"\"\<lt>cr>"
:inoremap <expr> <m-;> pumvisible() ? "\<lt>c-n>" : "\<lt>c-x>\<lt>c-o>\<lt>c-n>\<lt>c-p>\<lt>c-r>=pumvisible() ? \"\\<lt>down>\" : \"\"\<lt>cr>"

function! InsertTabWrapper(direction)
    let col = col('.') - 1
    if !col || getline('.')[col - 1] !~ '\k'
        return "\<tab>"
    elseif "backward" == a:direction
        return "\<c-p>"
    else
        return "\<c-n>"
    endif
endfunction

inoremap <tab> <c-r>=InsertTabWrapper ("forward")<cr>
inoremap <s-tab> <c-r>=InsertTabWrapper ("backward")<cr> 

"nobody really wants F1 to start vim's help...
inoremap <F1> <ESC>
noremap <F1> <ESC>

inoremap <C-A> <Home>
noremap <C-A> <Home>

inoremap <C-E> <End>
noremap <C-E> <End>

