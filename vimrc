" Vundle {
    set nocompatible
    filetype off
    set rtp+=~/.vim/bundle/Vundle.vim
    call vundle#begin()
    Plugin 'gmarik/Vundle.vim'
" }

" Plugins {
    Plugin 'Raimondi/delimitMate'
    Plugin 'walm/jshint.vim'
    Plugin 'scrooloose/syntastic'
    Plugin 'bling/vim-airline'
    Plugin 'jelera/vim-javascript-syntax'
    Plugin 'ap/vim-css-color'
    Plugin 'marijnh/tern_for_vim' " run npm install in ~/.vim/bundle/tern_for_vim
    Plugin 'Valloric/YouCompleteMe' " run ./install.sh in ~/.vim/bundle/YouCompleteMe

    call vundle#end()
" }

" Basics {
    set background=dark " we plan to use a dark background
    syntax on " syntaw highlighting on
" }

" General {
    filetype plugin indent on " load filetype plugin/indent settings
    set autochdir " Use the current file's directory as Vim's working directory
    set hidden " change buffers without saving
    set wildignore=*.jpg,*.gif,*.png " ignore this list file extensions
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
    endif
" }

let g:airline_powerline_fonts=1
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:delimitMate_expand_cr = 1
