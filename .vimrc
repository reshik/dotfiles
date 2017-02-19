
set nocompatible

python from powerline.vim import setup as powerline_setup
python powerline_setup()
python del powerline_setup

filetype on
filetype indent on
filetype plugin on

set laststatus=2

" Allow backspacing over everything in insert mode.
set backspace=indent,eol,start

set history=200         " keep 200 lines of command line history
set ruler               " show the cursor position all the time
set showcmd             " display incomplete commands
set wildmenu            " display completion matches in a status line
set number              " activate line numbers
set wrap
set linebreak
"set numberwidth=4
"set linespace=5
"set list		"show tabs, line endings
set ignorecase
set smartcase
set hlsearch		" highlight search matches
set autoindent
set showmatch
set gdefault

set ttimeout            " time out for key codes
set ttimeoutlen=100     " wait up to 100ms after Esc for special key

" Show @@@ in the last line if it is truncated.
set display=truncate

" Show a few lines of context around the cursor.  Note that this makes the
" text scroll if you mouse-click near the start or end of the window.
set scrolloff=5

" Do incremental searching when it's possible to timeout.
if has('reltime')
  set incsearch
endif

set fileencoding=utf-8
set encoding=utf-8

" Do not recognize octal numbers for Ctrl-A and Ctrl-X, most users find it
" confusing.
set nrformats-=octal

" For Win32 GUI: remove 't' flag from 'guioptions': no tearoff menu entries.
if has('win32')
  set guioptions-=t
endif

" Don't use Ex mode, use Q for formatting.
" Revert with ":unmap Q".
map Q gq

" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
" Revert with ":iunmap <C-U>".
inoremap <C-U> <C-G>u<C-U>

" In many terminal emulators the mouse works just fine.  By enabling it you
" can position the cursor, Visually select and scroll with the mouse.
if has('mouse')
  set mouse=a
endif

" Switch syntax highlighting on when the terminal has colors or when using the
" GUI (which always has colors).
if &t_Co > 2 || has("gui_running")
  " Revert with ":syntax off".
  syntax on

"  set t_ZH=[3m
"  set t_ZR=[23m
  let &t_ZH = "\e[3m"
  let &t_ZR = "\e[23m"
"  set term=screen-256color

  set t_Co=256 " vim-monokai now only support 256 colours in terminal.
  let g:monokai_term_italic = 1 " By default the gui enables italic but terminal. They both can be configured
  let g:monokai_gui_italic = 1
  colorscheme monokai

"  set guifont=Hack:h15
  set guifont=Cousine_for_Powerline:h16
  set guioptions-=l
  set guioptions-=L
  set guioptions-=r
  set guioptions-=R

  "Disable gui tabs
  set guioptions-=e

  " I like highlighting strings inside C comments.
  " Revert with ":unlet c_comment_strings".
  let c_comment_strings=1
endif

" Only do this part when compiled with support for autocommands.
if has("autocmd")

  " Enable file type detection.
  " Use the default filetype settings, so that mail gets 'tw' set to 72,
  " 'cindent' is on in C files, etc.
  " Also load indent files, to automatically do language-dependent indenting.
  " Revert with ":filetype off".
  filetype plugin indent on

  " Put these in an autocmd group, so that you can revert them with:
  " ":augroup vimStartup | au! | augroup END"
  augroup vimStartup
    au!

    " When editing a file, always jump to the last known cursor position.
    " Don't do it when the position is invalid or when inside an event handler
    " (happens when dropping a file on gvim).
    autocmd BufReadPost *
      \ if line("'\"") >= 1 && line("'\"") <= line("$") |
      \   exe "normal! g`\"" |
      \ endif

    " Automatically source .vimrc on save
    autocmd BufWritePost .vimrc source %

  augroup END

endif " has("autocmd")

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
" Revert with: ":delcommand DiffOrig".
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r ++edit # | 0d_ | diffthis
                  \ | wincmd p | diffthis
endif

if has('langmap') && exists('+langremap')
  " Prevent that the langmap option applies to characters that result from a
  " mapping.  If set (default), this may break plugins (but it's backward
  " compatible).
  set nolangremap
endif

"----------------Splits-------------------"
set splitbelow
set splitright


"----------------Mappings-------------------"

"let mapleader = ',' "Default leader is '\', this is alternative

"Make it easy to edit .vimrc file
nmap <Leader>ev :tabedit $MYVIMRC<cr>

"Add simple highlight removal
nmap <Leader><space> :nohlsearch<cr>



"----------------Vim Plug plugins-------------------"
" download vim-plug if missing
if empty(glob("~/.vim/autoload/plug.vim"))
  silent! execute '!curl --create-dirs -fsSLo ~/.vim/autoload/plug.vim https://raw.github.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * silent! PlugInstall
endif

call plug#begin('~/.vim/plugged')

Plug 'tpope/vim-vinegar'

Plug 'ctrlpvim/ctrlp.vim'
nmap <Leader>mr :CtrlPMRUFiles<cr>

" On-demand loading
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
let NERDTreeHijackNetrw = 0
nmap <Leader>1 :NERDTreeToggle<cr>

"Add plugins to &runtimepath
call plug#end()

