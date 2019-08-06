" When started as "evim", evim.vim will already have done these settings.
if v:progname =~? "evim"
  finish
endif

" Use Vim settings, rather than Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible
filetype off
let vundle_readme=expand('~/.vim/bundle/vundle/README.md')
if !filereadable(vundle_readme)
    echo "Installing Vundle.."
    echo ""
    !mkdir -p ~/.vim/bundle
    !git clone https://github.com/gmarik/vundle $HOME/.vim/bundle/vundle
endif
"call pathogen#infect()
set rtp+=~/.vim/bundle/vundle/
call vundle#begin()

" let Vundle manage Vundle
" required! 
Plugin 'gmarik/vundle'

if has('python3') || has('python')
    Plugin 'Valloric/YouCompleteMe'
endif
"Plugin 'lukerandall/haskellmode-vim'
"Plugin 'dag/vim2hs'
Plugin 'scrooloose/syntastic'
Plugin 'pbrisbin/html-template-syntax'
Plugin 'scrooloose/nerdcommenter'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'gerw/vim-latex-suite'
Plugin 'tpope/vim-surround'
Plugin 'tomasr/molokai'
Plugin 'jpalardy/vim-slime'
Plugin 'idris-hackers/idris-vim'
Plugin 'rust-lang/rust.vim'
Plugin 'qnighy/lalrpop.vim'

Plugin 'Shougo/vimproc.vim'
Plugin 'neovimhaskell/haskell-vim'
Plugin 'ujihisa/neco-ghc'
Plugin 'bitc/vim-hdevtools'
Plugin 'hashivim/vim-terraform'
Plugin 'saltstack/salt-vim'
call vundle#end()

filetype plugin indent on

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

if has("vms")
  set nobackup		" do not keep a backup file, use versions instead
else
  set backup		" keep a backup file
endif
set backupdir=~/.backup//,.,/tmp//
set directory=.,~/.backup//,/tmp//
set history=50		" keep 50 lines of command line history
set ruler		" show the cursor position all the time
set showcmd		" display incomplete commands
set incsearch		" do incremental searching
set so=5
set magic

" Don't use Ex mode, use Q for formatting
map Q gq

" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
inoremap <C-U> <C-G>u<C-U>

" In many terminal emulators the mouse works just fine, thus enable it.
"if has('mouse')
"  set mouse=a
"endif

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  set t_Co=256
  set hlsearch
  syntax on
endif

" Only do this part when compiled with support for autocommands.
if has("autocmd")

  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
  au!

  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=78
  
  au FileType python setlocal tabstop=8 expandtab shiftwidth=4 softtabstop=4 foldmethod=indent
  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  " Also don't do it when the mark is in the first line, that is the default
  " position when opening a file.
  autocmd BufReadPost *
    \ if line("'\"") > 1 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif

  augroup END


endif " has("autocmd")

set autoindent		" always set autoindenting on

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis
		  \ | wincmd p | diffthis
endif

set nomodeline
set nu
set ttyfast
set shiftwidth=4
set softtabstop=4
set expandtab
colorscheme molokai
nnoremap <Space> za
vnoremap <Space> za
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
set formatoptions=croqln1
let mapleader = ","
let maplocalleader = "\\"
"nnoremap / /\v
"vnoremap / /\v
set showmode
noremap <Leader>R :RainbowParenthesesToggle<CR>
set laststatus=2
au InsertEnter * hi StatusLine term=reverse ctermbg=5 gui=undercurl guisp=Magenta
au InsertLeave * hi StatusLine term=reverse ctermfg=0 ctermbg=2 gui=bold,reverse
set smartcase
set foldmethod=syntax
set foldlevelstart=99
let javaScript_fold=1         " JavaScript
let perl_fold=1               " Perl
let php_folding=1             " PHP
let r_syntax_folding=1        " R
let ruby_fold=1               " Ruby
let sh_fold_enabled=1         " sh
let vimsyn_folding='af'       " Vim script
let xml_syntax_folding=1      " XML

"au Bufenter *.hs compiler ghc
"au Bufenter *.hs syntax on

function! SetOIMode()
    verbose set makeprg=g++\ -ggdb\ -std=c++11\ -Wall\ %\ -o\ %<
    nmap <F5> :!./%<<CR>
    nmap <C-F5> <F9><F5>
endfunction
nmap <F9> :w<CR>:make<CR>
command! OIMode :call SetOIMode()
let g:Tex_DefaultTargetFormat="pdf"

let g:syntastic_auto_loc_list=1
"let g:syntastic_disabled_filetypes=['html']
let g:syntastic_enable_signs=1
let g:syntastic_check_on_open=1
let g:syntastic_mode_map = { 'mode': 'active',
    \ 'active_filetypes': [],
    \ 'passive_filetypes': ['html'] }
let g:syntastic_python_python_exec = 'python'
let g:syntastic_python_checkers=['python', 'pyflakes']
let g:syntastic_idris_checkers=[]
let g:syntastic_rust_checkers=[]

let g:syntastic_asm_dialect="intel"

" neovimhaskell/haskell-vim  (syntax stuff)
let g:haskell_enable_quantification = 1
let g:haskell_indent_before_where = 2

" neco-ghc
autocmd FileType haskell setlocal omnifunc=necoghc#omnifunc
" ---- todo not relevant?
" Disable haskell-vim omnifunc
" let g:haskellmode_completion_ghc = 0

"let g:hdevtools_options = '-g-hide-package -gmonads-tf'
let g:ycm_global_ycm_extra_conf = '~/.vim/.ycm_extra_conf.py'
let g:ycm_always_populate_location_list = 1
syntax on
let g:ycm_semantic_triggers = {'haskell' : ['.']}
let g:necoghc_enable_detailed_browse = 1
au FileType haskell nnoremap <buffer> <leader>t :HdevtoolsType<CR>
au FileType haskell nnoremap <buffer> <silent> <leader>T :HdevtoolsClear<CR>

set guioptions-=T
let g:ctrlp_max_files=0
let g:Tex_AdvancedMath = 1
set winaltkeys=no
