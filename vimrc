set nocompatible

" Plugins {
    call plug#begin()
    Plug 'Raimondi/delimitMate'
    Plug 'walm/jshint.vim'
    Plug 'benekastah/neomake'
    Plug 'bling/vim-airline'
    Plug 'tpope/vim-vinegar'
    Plug 'jelera/vim-javascript-syntax'
    Plug 'pangloss/vim-javascript'
    Plug 'tpope/vim-surround'
    Plug 'airblade/vim-gitgutter'
    Plug 'ap/vim-css-color'
    Plug 'kien/ctrlp.vim'
    Plug 'tpope/vim-fugitive'
    Plug 'tpope/vim-repeat'
    Plug 'tpope/vim-unimpaired'
    Plug 'marijnh/tern_for_vim', { 'do': 'npm install'}
    Plug 'Valloric/YouCompleteMe', { 'do': 'python install.py' }
    Plug 'mattn/emmet-vim'
    call plug#end()
" }
" python support in neovim: sudo pip install neovim

" Basics {
    set background=dark " we plan to use a dark background
" }

" General {
    set autochdir " Use the current file's directory as Vim's working directory
    set hidden " change buffers without saving
    set wildignore=*/node_modules/*,*.jpg,*.gif,*.png " ignore this list file extensions
    set wildmenu " show autocomplete menus
    set wildmode=list:longest,full " command-line completion
    set shm=a " abbreviate all messages
    set autoread " reload a file if it was modified outside of vim
    set directory=~/.vim/tmp,/var/tmp,/tmp " write .swp files in a single directory
    set undodir=~/.vim/undo
    set undofile " make undo persistent
    set history=1000
    set scrolloff=2 " keep at least 2 lines above/below
    set encoding=utf-8
    set t_Co=256 " use 256 colors
    set backspace=indent,eol,start " backspace through anything in insert mode. Necessary for delimitMate expand cr option
" }

" Vim UI {
    colorscheme distinguished
    set title " show title
    :auto BufEnter * let &titlestring = hostname() . ": " . expand("%:p") " change window title
    set cursorline  " highlight current line
    set ignorecase " case insensitive search
    set incsearch   " Incremental search
    set laststatus=2 " always show status line
    set list " show non printable chars
    set listchars=tab:>-,trail:-,nbsp:· " Show non breakable space as ·
    set number      " show line number
    set showcmd     " Show (partial) command in status line.
    set showmatch   " Show matching brackets.
    set smartcase   " Do smart case matching
    set suffixesadd=.js " Allow to gf on require('./jsfile')
    " set statusline=%F%m%r%h%w[%L][%{&ff}]%y[%p%%][%04l,%04v]
    "              | | | | |  |   |      |  |     |    |
    "              | | | | |  |   |      |  |     |    + current
    "              | | | | |  |   |      |  |     |       column
    "              | | | | |  |   |      |  |     +-- current line
    "              | | | | |  |   |      |  +-- current % into file
    "              | | | | |  |   |      +-- current syntax in
    "              | | | | |  |   |          square brackets
    "              | | | | |  |   +-- current fileformat
    "              | | | | |  +-- number of lines
    "              | | | | +-- preview flag in square brackets
    "              | | | +-- help flag in square brackets
    "              | | +-- readonly flag in square brackets
    "              | +-- rodified flag in square brackets
    "              +-- full path to file in the buffer
    set statusline+=%#warningmsg#
    set statusline+=%{SyntasticStatuslineFlag()}
    set statusline+=%*

" }

" Text formatting/layout {
    set autoindent " keep indentation after newline
    set expandtab " convert tab to spaces
    set shiftround " when at 3 spaces, and I hit > ... go to 4, not 5
    set shiftwidth=4 " Defaut indentation width
    set softtabstop=4 " number of spaces inserted when hitting <Tab>
    set tabstop=4 " Number of spaces of a real <Tab>
    set nojoinspaces " do not append spaces when joining lines
    " set wrapmargin=10
" }

" Mappings {
    " use space to scroll down
    nnoremap <Space> <C-D>
    " :W to edit current file with root privileges
    command W w !sudo tee %
    " load/save session
    nnoremap <F5> :wa<CR>:mksession! ~/.vim/session.vim<CR>
    nnoremap <F6> :so ~/.vim/session.vim<CR>
    " find
    nnoremap  :find 
" }

" Completion {
    set dictionary=/usr/share/myspell/dicts/fr.dic
    set complete=.,d,i,t
    set omnifunc=syntaxcomplete#Complete
    set spelllang=fr
" }

" Autocommands {
    if has("autocmd")
        let blacklist = ['vim']
        au BufWritePre * if index(blacklist, &ft) < 0 | :%s/\s\+$//e " Automatically delete trailing spaces
        au FileType html,xhtml let b:delimitMate_autoclose = 0
    endif
" }

" Neomake
autocmd! BufWritePost * Neomake
let g:neomake_javascript_enabled_makers = ['eslint']

let g:airline_powerline_fonts=1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#whitespace#enabled = 0
let g:delimitMate_expand_cr = 1
let g:ctrlp_custom_ignore = '\v[\/]\.(git|hg|svn)$'
let g:ycm_autoclose_preview_window_after_completion = 1

" Handle large files
let g:LargeFile = 1024 * 1024 * 10
augroup LargeFile
autocmd BufReadPre * let f=getfsize(expand("<afile>")) | if f > g:LargeFile || f == -2 | call LargeFile() | endif
augroup END

function LargeFile()
    set eventignore+=FileType " no syntax highlighting etc
    setlocal bufhidden=unload " save memory when other file is viewed
    setlocal buftype=nowrite " is read-only (write with :w new_filename)
    setlocal undolevels=-1 " no undo possible
    autocmd VimEnter *  echo "The file is larger than " . (g:LargeFile / 1024 / 1024) . " MB, so some options are changed (see .vimrc for details)."
endfunction
