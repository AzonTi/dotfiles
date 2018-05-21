augroup MyVimrc
	autocmd!
augroup END

set nocompatible

filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'

Plugin 'derekwyatt/vim-scala'

Plugin 'fatih/vim-go'
Plugin 'mdempsky/gocode', {'rtp': 'vim/'}

Plugin 'lervag/vimtex'

call vundle#end()
filetype plugin indent on

set enc=utf-8
set fencs=utf-8,cp932

set swapfile
set nobackup

set autoread
set autowrite

set hidden

set confirm

set showcmd


set ambiwidth=double

augroup MyVimrc
	autocmd ColorScheme * highlight UnicodeSpaces cterm=underline ctermfg=59 ctermbg=16 gui=underline guifg=#465457 guibg=#000000
	autocmd VimEnter,WinEnter * match UnicodeSpaces /\%u180E\|\%u2000\|\%u2001\|\%u2002\|\%u2003\|\%u2004\|\%u2005\|\%u2006\|\%u2007\|\%u2008\|\%u2009\|\%u200A\|\%u2028\|\%u2029\|\%u202F\|\%u205F\|\%u3000/
augroup END

syntax on
colorscheme koehler

set list
set listchars=tab:»-,trail:￮,eol:￩,extends:»,precedes:«,nbsp:￭

set number

set nocursorline
set nocursorcolumn

set smartindent

set novisualbell

set showmatch

set laststatus=2

set wildmode=list:longest

set tabstop=2
set shiftwidth=2


set ignorecase
set smartcase

set hlsearch

set incsearch

set wrapscan


noremap <Up> <Nop>
noremap <Down> <Nop>
noremap <Left> <Nop>
noremap <Right> <Nop>
noremap <PageUp> <Nop>
noremap <PageDown> <Nop>
noremap <Home> <Nop>
noremap <End> <Nop>
inoremap <Up> <Nop>
inoremap <Down> <Nop>
inoremap <Left> <Nop>
inoremap <Right> <Nop>
inoremap <PageUp> <Nop>
inoremap <PageDown> <Nop>
inoremap <Home> <Nop>
inoremap <End> <Nop>
