let $CACHE = expand('~/.cache')
if !isdirectory($CACHE)
  call mkdir($CACHE, 'p')
endif
if &runtimepath !~# '/dein.vim'
  let s:dein_dir = fnamemodify('dein.vim', ':p')
  if !isdirectory(s:dein_dir)
    let s:dein_dir = $CACHE . '/dein/repos/github.com/Shougo/dein.vim'
    if !isdirectory(s:dein_dir)
      execute '!git clone https://github.com/Shougo/dein.vim' s:dein_dir
    endif
  endif
  execute 'set runtimepath^=' . substitute(
        \ fnamemodify(s:dein_dir, ':p') , '[/\\]$', '', '')
endif

" begin settings {{{
if dein#load_state(s:dein_dir)
  call dein#begin(s:dein_dir)

  " .toml file
  let s:rc_dir = expand('~/.vim')
  if !isdirectory(s:rc_dir)
    call mkdir(s:rc_dir, 'p')
  endif
  let s:toml = s:rc_dir . '/dein.toml'

  " read toml and cache
  call dein#load_toml(s:toml, {'lazy': 0})

  " end settings
  call dein#end()
  call dein#save_state()
endif
" }}}

" plugin installation check {{{
if dein#check_install()
  call dein#install()
endif
" }}}

" plugin remove check {{{
let s:removed_plugins = dein#check_clean()
if len(s:removed_plugins) > 0
  call map(s:removed_plugins, "delete(v:val, 'rf')")
  call dein#recache_runtimepath()
endif
" }}}

" activate syntax highlighting
syntax on
set encoding=utf-8
" VIM color setting
if (has("nvim"))
    " For Neovim 0.1.3 and 0.1.4 < https://github.com/neovim/neovim/pull/2198 >
    let $NVIM_TUI_ENABLE_TRUE_COLOR=1
endif
if (has("termguicolors"))
    set termguicolors
endif
colorscheme onedark
set background=dark

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
" vim-airline settings
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#buffer_idx_mode = 1
let g:airline_theme='onedark'
