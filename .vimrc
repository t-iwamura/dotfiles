syntax on
set encoding=utf-8

" TAB settings
" how many spaces are regarded as tab
set tabstop=4
" automatically added spaces by indent
set shiftwidth=4
" don't cast spaces of shiftwidth into tab
set expandtab
" add spaces of shiftwidth when depressing tab key
set smarttab

" display settings
" show status line
set laststatus=2
" display column number
set number
" use relative column number
if exists("&relativenumber")
    set relativenumber
    au BufReadPost * set relativenumber
endif
" always display 5 lines around the cursor when scrolling
set scrolloff=5
" highlight current line number
set cursorline
" show invisible spaces
set list

" editting settings
" Remap Esc key in vim
inoremap jj <Esc>
" enable complementation in command line
set virtualedit=onemore
" enable to move to column end
set wildmode=list:longest
" don't make swap file
set noswapfile
" output content of yank or selection to clipboard
set clipboard=unnamed,autoselect
" automatically indent when begining a new line
set autoindent
" show the parenthese to match that before it
set showmatch
" Add g option by default when searching/replacing strings
set gdefault
" highlight detected strings
set hlsearch
" highlight strings dynamically when searching for pattern
set incsearch

" Plugins Settings
" onedark.vim Settings
if (has("termguicolors"))
    set termguicolors
endif
packadd! onedark.vim
colorscheme onedark

" vim-airline Settings
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#buffer_idx_mode = 1
let g:airline_theme='onedark'
