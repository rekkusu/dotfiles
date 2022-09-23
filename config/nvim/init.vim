
if &compatible
  set nocompatible
endif

if has('nvim')
  let $NVIM_TUI_ENABLE_TRUE_COLOR=1
endif

let $CACHE = expand('~/.cache')
let $TMPDIR = expand("$CACHE/vimbackup")
let $CONFIG = expand('~/.config')
let s:dein_dir = expand("$CACHE/vim/dein")

if !isdirectory($CACHE)
  call mkdir($CACHE, 'p')
  if !isdirectory($TMPDIR)
    call mkdir(expand($TMPDIR), 'p')
    call mkdir(expand("$TMPDIR/backup"), 'p')
    call mkdir(expand("$TMPDIR/swap"), 'p')
    call mkdir(expand("$TMPDIR/undo"), 'p')
  endif
endif

let g:python3_host_prog = expand('/usr/bin/python3')

if !isdirectory(expand(s:dein_dir))
  call mkdir(expand(s:dein_dir), 'p')
endif

" dein.vim
let s:dein_vim_dir = s:dein_dir . "/repos/github.com/Shougo/dein.vim"
if !isdirectory(s:dein_vim_dir)
  execute '!git clone https://github.com/Shougo/dein.vim' s:dein_vim_dir
endif
execute 'set runtimepath^=' . substitute(fnamemodify(s:dein_vim_dir, ':p') , '/$', '', '')

" set mapleader before loading plugins
let mapleader = "\<Space>"

if dein#load_state(s:dein_dir)
  let s:dein_toml = [expand('<sfile>')] + split(glob(expand('$CONFIG/nvim/dein/') . '*.toml'), '\n')
  call dein#begin(s:dein_dir, s:dein_toml)
  call dein#load_toml(expand('$CONFIG/nvim/dein/dein.toml'), {'lazy': 0})
  call dein#load_toml(expand('$CONFIG/nvim/dein/dein_lazy.toml'), {'lazy': 1})
  call dein#end()
  call dein#save_state()
  call dein#call_hook("source")
endif

filetype plugin indent on
syntax enable
colorscheme wombat256mod

if dein#check_install()
  call dein#install()
endif

" set options {{{
set cursorline number showmatch
set guioptions&
set guioptions-=T
set guioptions-=m
set smartindent autoindent
set shiftwidth=2 expandtab tabstop=2 softtabstop=2
set laststatus=2
set backupdir=$TMPDIR/backup
set directory=$TMPDIR/swap
set noswapfile
set undodir=$TMPDIR/undo
set undofile
set splitbelow splitright
set modeline
set guifont=Monaco:h13
set autoread
set ambiwidth=single
set hidden
set list
set listchars=eol:$,tab:>-,trail:-
set foldenable foldmethod=marker foldcolumn=2 foldtext=FoldCCtext()
set completeopt-=preview
set fileencodings=utf-8,euc-jp,sjis,iso-2022-jp
set backspace=indent,eol,start
set wrapscan
set wildmenu
set formatoptions&
set formatoptions+=mM
set ruler wrap showcmd title
set cmdheight=2
set ignorecase smartcase
set history=500
set visualbell t_vb=
set mouse=a
set showmatch
set matchtime=1
set hlsearch
set scrollback=1000

"enable truecolor
if exists('+termguicolors')
  set termguicolors
  set pumblend=20
  set winblend=20
endif

" tex default
let g:tex_flavor = "latex"

" clipboard
if stridx(system('uname -r'), 'microsoft')
  let g:clipboard = {
          \   'name': 'win32yank',
          \   'copy': {
          \      '+': '/mnt/c/Users/rex/Applications/win32yank/win32yank.exe -i',
          \    },
          \   'paste': {
          \      '+': '/mnt/c/Users/rex/Applications/win32yank/win32yank.exe -o',
          \   },
          \   'cache_enabled': 0,
          \ }
endif

" }}}

runtime init/keymap.vim
runtime init/autocmd.vim
runtime init/highlight.vim
if filereadable(expand('$CONFIG/nvim/init/env.vim'))
  runtime init/env.vim
endif
