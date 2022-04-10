if &compatible
  set nocompatible " Be iMproved
endif

" define install_dir variable {{{
let s:dein_dir = expand('~/.cache/dein')
let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'
" }}}

" Required:
set runtimepath+=${HOME}/.cache/dein/repos/github.com/Shougo/dein.vim

" Required:
call dein#begin(s:dein_dir)

" Let dein manage dein
" Required:
call dein#add(s:dein_repo_dir)

" Add or remove your plugins here like this:
"call dein#add('Shougo/deoplete.nvim')
"call dein#add('Shougo/neosnippet-snippets')

" Required:
call dein#end()

" Required:
filetype plugin indent on
syntax enable

" If you want to install not installed plugins on startup.
"if dein#check_install()
"  call dein#install()
"endif

" dein.vim settings {{{

" dein installation check {{{
if &runtimepath !~# '/dein.vim'
  if !isdirectory(s:dein_repo_dir)
    execute '!git clone https://github.com/Shougo/dein.vim' s:dein_repo_dir
  endif
  execute 'set runtimepath^=' . s:dein_repo_dir
endif
" }}}

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
let g:hybrid_custom_term_colors = 1
set background=dark
colorscheme hybrid

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
let g:airline_theme='dark'

" coc.nvim settings
set hidden
set nobackup
set nowritebackup
" Give more space for displaying messages.
set cmdheight=2
" extend updatetime
set updatetime=300
" Don't pass messages to |ins-completion-menu|.
set shortmess+=c
" Always show the signcolumn
if has("nvim-0.5.0") || has("patch-8.1.1564")
  set signcolumn=number
else
  set signcolumn=yes
endif
" Use tab for trigger completion with characters ahead and navigate.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Make <CR> auto-select the first completion item
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" GoTo code navigation
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)

