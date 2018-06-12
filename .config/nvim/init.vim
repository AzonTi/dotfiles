"""  init
augroup MyVimrc
	autocmd!
augroup END

if &compatible
	set nocompatible
endif

""" envs
let g:cache_home = empty($XDG_CACHE_HOME) ? expand('$HOME/.cache') : $XDG_CACHE_HOME
let g:config_home = empty($XDG_CONFIG_HOME) ? expand('$HOME/.config') : $XDG_CONFIG_HOME


""" plugins
let s:dein_dir = g:cache_home . '/dein'

let s:dein_repo = 'Shougo/dein.vim'
if &runtimepath !~# s:dein_repo
	let s:dein_repo_dir = s:dein_dir . '/repos/github.com/' . s:dein_repo

	if !isdirectory(s:dein_repo_dir)
		call system('git clone https://github.com/' . s:dein_repo . ' ' . shellescape(s:dein_repo_dir))
	endif

	execute 'set runtimepath+=' . s:dein_repo_dir
endif

if dein#load_state(s:dein_dir)
	call dein#begin(s:dein_dir)

	call dein#add(s:dein_repo)

	call dein#add('posva/vim-vue')

	call dein#add('tpope/vim-fugitive')

	call dein#add('Shougo/deoplete.nvim')
	if !has('nvim')
		call dein#add('roxma/nvim-yarp')
		call dein#add('roxma/vim-hug-neovim-rpc')
	endif
	call dein#add('Shougo/neosnippet.vim')
	call dein#add('Shougo/neosnippet-snippets')

	call dein#add('carlitux/deoplete-ternjs')
	call dein#add('autozimu/LanguageClient-neovim', {
		\ 'rev': 'next',
		\ 'build': 'bash install.sh',
		\ })

	call dein#add('w0rp/ale')

	call dein#add('844196/lightline-badwolf.vim')
	call dein#add('itchyny/lightline.vim')

	call dein#add('scrooloose/nerdtree')

	call dein#add('miyakogi/seiya.vim')
	call dein#add('sjl/badwolf')

	call dein#add('ryanoasis/vim-devicons')	

	call dein#end()
	call dein#save_state()
endif

if dein#check_install()
	call dein#install()
	call dein#remote_plugins()
endif


""" edit
filetype plugin indent on

set enc=utf-8
set fencs=utf-8,cp932

set swapfile
set nobackup
if has('persistent_undo')
	execute 'set undodir=' . g:cache_home . '/nvim/undo'
	set undofile
endif

set autoread
set autowrite

set hidden

set confirm

let g:LanguageClient_serverCommands = {
		\ 'vue': ['vls'],
		\ }
setlocal iskeyword+=$
setlocal iskeyword+=-

let g:deoplete#enable_at_startup = 1

let g:ale_fixers=[ 'eslint' ]
let g:ale_fix_on_save=1


""" view
augroup MyVimrc
	autocmd ColorScheme * highlight UnicodeSpaces cterm=underline ctermfg=59 ctermbg=16 gui=underline guifg=#465457 guibg=#000000
	autocmd VimEnter,WinEnter * match UnicodeSpaces /\%u180E\|\%u2000\|\%u2001\|\%u2002\|\%u2003\|\%u2004\|\%u2005\|\%u2006\|\%u2007\|\%u2008\|\%u2009\|\%u200A\|\%u2028\|\%u2029\|\%u202F\|\%u205F\|\%u3000/
augroup END

let g:seiya_auto_enable=1

syntax on
colorscheme badwolf

set list
set listchars=tab:»-,trail:￮,eol:￩,extends:»,precedes:«,nbsp:￭

set number

set showcmd
set noshowmode

set cursorline
set nocursorcolumn

set smartindent

set novisualbell

set showmatch

set laststatus=2

set wildmode=list:longest

set expandtab

set tabstop=2
set shiftwidth=2

augroup MyVimrc
	autocmd StdinReadPre * let s:std_in=1
	autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
augroup END

let g:lightline = { 'colorscheme' : 'badwolf' }
let g:lightline.active = {
	\   'left': [ ['mode', 'paste'],
	\             ['fugitive', 'readonly', 'filename', 'modified'] ],
	\   'right': [ [ 'lineinfo' ],
	\              [ 'percent', 'ale' ],
	\              [ 'fileformat', 'fileencoding', 'filetype' ] ]
	\ }
let g:lightline.tabline = {
	\ 'left': [ [ 'tabs' ] ]
	\ }

let g:lightline.component_function = {
	\   'modified': 'LightLineModified',
	\   'readonly': 'LightLineReadonly',
	\   'fugitive': 'LightLineFugitive',
	\   'filename': 'LightLineFilename',
	\   'fileformat': 'LightLineFileformat',
	\   'filetype': 'LightLineFiletype',
	\   'fileencoding': 'LightLineFileencoding',
	\   'mode': 'LightLineMode',
	\   'ale': 'LightLineAle'
	\ }

let g:lightline.separator = {
	\   'left': "", 'right': ""
	\ }

let g:lightline.subseparator = {
	\ 'left': "", 'right': ''
	\ }

function! LightLineModified()
	return &ft =~ 'help\|nerdtree' ? '' : &modified ? '+' : &modifiable ? '' : '-'
endfunction

function! LightLineReadonly()
	return &ft !~? 'help\|nerdtree' && &readonly ? ' ' : ''
endfunction

function! LightLineFilename()
	return (&ft == 'denite' ? denite#get_status_sources() : (&ft == 'nerdtree' ? expand('%:~:h') : '' != expand('%:t') ? expand('%:~:.:h') . '/'. expand('%:t') : '[No Name]'))
endfunction

function! LightLineFiletype()
	return winwidth(0) > 70 ? (strlen(&filetype) ? &filetype . ' ' . WebDevIconsGetFileTypeSymbol()[0:2] : 'no ft') : ''
endfunction

function! LightLineFileformat()
	return winwidth(0) > 70 ? (&fileformat . ' ' . WebDevIconsGetFileFormatSymbol()) : ''
endfunction

function! LightLineFileencoding()
	return  &ft == 'nerdtree' ? '' : winwidth(0) > 70 ? (strlen(&fenc) ? &fenc : &enc) : ''
endfunction

function! LightLineMode()
	return  &ft == 'denite' ? 'Denite' : &ft == 'nerdtree' ? 'NERDTree' : winwidth(0) > 60 ? lightline#mode() : ''
endfunction

augroup MyVimrc
	autocmd User ALELint call lightline#update()
augroup END

function! LightLineAle()
	return &ft == 'denite' ? '' : &ft == 'nerdtree' ? '' : ALEGetStatusLine()
endfunction

function! LightLineFugitive()
	try
		if &ft !~? 'vimfiler\|gundo\|vaffle' && exists('*fugitive#head')
			let _ = fugitive#head()
			return strlen(_) ? ' '._ : ''
		endif
	catch
	endtry
	return ''
endfunction

let g:WebDevIconsUnicodeDecorateFolderNodes=1
let g:DevIconsEnableFoldersOpenClose=1

let g:ale_sign_column_always=1


""" search
set ignorecase
set smartcase

set hlsearch

set incsearch

set wrapscan


""" key
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

noremap <C-t> :NERDTreeToggle<LF>
noremap <C-x> :ALEFix<LF>
imap <expr><tab> pumvisible() ? "\<C-n>" : neosnippet#expandable_or_jumpable() ? "\<Plug>(neosnippet_expand_or_jump)" : "\<tab>"
imap <C-k> <Plug>(neosnippet_expand_or_jump)
smap <C-k> <Plug>(neosnippet_expand_or_jump)
xmap <C-k> <Plug>(neosnippet_expand_target)
if has('conceal')
	set conceallevel=2 concealcursor=niv
endif
