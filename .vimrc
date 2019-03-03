set rubydll=/opt/local/lib/libruby.2.6.dylib
set pythondll=/opt/local/Library/Frameworks/Python.framework/Versions/2.7/lib/libpython2.7.dylib
set nocompatible
behave mswin

source $VIMRUNTIME/mswin.vim
source $HOME/.vim/cscope_maps.vim
source $HOME/.vim/python_fn.vim
" Autoload package bundles
call pathogen#runtime_append_all_bundles()

set exrc   " enable per-directory .vimrc files
set secure   " disable unsafe commands in local .vimrc files

" source $HOME/.vim/ropevim.vim

set selection=inclusive
set ruler       " show the cursor position all the time
set showcmd     " display incomplete commands
set number      " set line numbers
set laststatus=2


filetype on
filetype plugin on

au BufRead,BufNewFile *.ts        setlocal filetype=typescript

" Remember more commands and search history
set history=1000
set scrollopt=jump

" Keep more context when scrolling off the end of a buffer
set scrolloff=3

"search options
"set ignorecase
set smartcase
set incsearch
set showmatch   "show matching parens
set hlsearch

set wildignore=*.o,*.obj,*.bak,*.exe,*.pyc,*.pyo,*~
set wildmenu

"black colorscheme
let g:solarized_contrast="high"    "default value is normal
let g:solarized_visibility="high"    "default value is normal
syntax enable
set background=dark
"colorscheme solarized
colorscheme torte
syntax sync fromstart
let g:ycm_show_diagnostics_ui = 0
let g:python_highlight_space_errors=1
let g:syntastic_python_checkers = ['pyflakes']
let g:syntastic_javascript_checkers = ['eslint']
let g:syntastic_javascript_eslint_exec = 'eslint_d'
let g:syntastic_typescript_checkers = ['tslint']
let g:syntastic_css_checkers = ['stylelint']
let g:syntastic_c_checkers = ['clang_check']
let g:indent_guides_guide_size=1
let g:indent_guides_enable_on_vim_startup=1

let g:CommandTHighlightColor='StatusLine'
let g:CommandTAcceptSelectionCommand='e'

let g:tagbar_ctags_bin="/opt/local/bin/ctags"

" haskell stuff
" use ghc functionality for haskell files
au Bufenter *.hs compiler ghc
" Configure browser for haskell_doc.vim
let g:haddock_browser = "open"
let g:haddock_browser_callformat = "%s %s"

set backspace=eol,start,indent

"proper tab handling (insert spaces)
set tabstop=2
set shiftwidth=2
set expandtab
set softtabstop=2
set autoindent
set smarttab
set smartindent

"mouse always enabled (also in terminal)
set mouse=a

"proper autocomplete
set completeopt=longest,menuone
"inoremap <expr> <cr> pumvisible() ? "\<c-y>" : "\<c-g>u\<cr>"
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


"Edit mapping (make cursor keys work like in Windows: <C-Left><C-Right>
"Move to next word.
"nnoremap <C-Left> b
"vnoremap <C-S-Left> b
"nnoremap <C-S-Left> gh<C-O>b
"inoremap <C-S-Left> <C-O>gh<C-O>b

"nnoremap <C-Right> w
"vnoremap <C-S-Right> w
"nnoremap <C-S-Right> gh<C-O>w
"inoremap <C-S-Right> <C-O>gh<C-O>w

" Natural split movement
nnoremap <C-Down> <C-W><C-J>
nnoremap <C-Up> <C-W><C-K>
nnoremap <C-Right> <C-W><C-L>
nnoremap <C-Left> <C-W><C-H>

set splitbelow
set splitright

" easily insert pudb ;)
map! <F2> import pdb; pdb.set_trace()<Esc>


cmap w!! %!sudo tee > /dev/null %

"OSX specific
if has("gui_macvim")
    let macvim_hig_shift_movement = 1
endif


set wildignore+=*/build/*
set wildignore+=*/dist/*
set wildignore+=doc/_build/*
set wildignore+=*/*.egg-info
set wildignore+=*/node_modules/*
set wildignore+=*/webpack-cache/*
set wildignore+=*/venv/*
