set nocompatible              " be iMproved, required
"filetype off                  " required

" Add the virtualenv's site-packages to vim path
if has('python')
py << EOF
import os.path
import sys
import vim
if 'VIRTUAL_ENV' in os.environ:
  project_base_dir = os.environ['VIRTUAL_ENV']
  sys.path.insert(0, project_base_dir)
  activate_this = os.path.join(project_base_dir, 'bin/activate_this.py')
  execfile(activate_this, dict(__file__=activate_this))
EOF
endif

" Load up virtualenv's vimrc if it exists
if filereadable($VIRTUAL_ENV . '/vimrc')
  source $VIRTUAL_ENV/vimrc
endif

let g:indentobject_meaningful_indentation = ["python", "markdown", "ocaml"]
autocmd FileType python setlocal completeopt-=preview

if &term == 'xterm' || &term == 'screen' || &term == 'tmux'
	set t_Co=256    " Enable 256 colors to stop the CSApprox warning and
                  " make xterm vim shine
endif

" solarized needs more contrast!
let g:solarized_contrast="high"


filetype plugin indent on " required

" An example for a vimrc file.
"
" Maintainer:  Bram Moolenaar <Bram@vim.org>
" Last change:  2002 Sep 19
"
" To use it, copy it to
"     for Unix and OS/2:  ~/.vimrc
"        for Amiga:  s:.vimrc
"  for MS-DOS and Win32:  $VIM\_vimrc
"      for OpenVMS:  sys$login:.vimrc

" When started as "evim", evim.vim will already have done these settings.
if v:progname =~? "evim"
  finish
endif

" General options.
set autoindent                  " always set auto-indenting on.
set autoread
set backspace=indent,eol,start  " allow backspacing over everything in insert mode
set cindent
set colorcolumn=+1
set diffopt+=iwhite        " Ignore whitespace changes (focus on code changes).
set diffopt=filler         " Add vertical spaces to keep right and left aligned.
scriptencoding utf-8
set encoding=utf-8 nobomb  " BOM often causes trouble?
set esckeys                " Allow cursor keys in insert mode.
set expandtab              " Expand tabs to spaces
set foldcolumn=0           " Column to show folds (I kinda don't like it)
set foldlevel=20
set foldlevelstart=20      " Sets `foldlevel` when editing a new buffer
set foldmethod=indent      " Markers are used to specify folds.
set formatoptions=qrn1
set guifont=Monospace\ 9
set hidden              " When a buffer is brought to foreground, remember undo
                        " history and marks.
set history=500         " keep 500 lines of command line history
set laststatus=2        " Always show status line
set linebreak           " So that wrapping breaks at words, not just 'wherever'
set magic               " Enable extended regexes.
set mouse=a
set nobackup            " do not keep a backup file, use versions instead
set nocompatible        " (Also above).
set noerrorbells        " Disable error bells.
set noshowmode
set nostartofline
set report=0            " Show all changes.
set ruler               " Show the cursor position all the time
set shiftwidth=2        " The # of spaces for indenting.
set shortmess=I         " Don't show the intro message when starting vim.
set showcmd             " display incomplete commands
set showmode            " Show the current mode.
set showtabline=2       " Always show tab bar.
set smarttab            " At start of line, <Tab> inserts shiftwidth spaces,
                        " <Bs> deletes shiftwidth spaces.
set softtabstop=2
set spell spelllang=en_us,de
set tabstop=2
set textwidth=80
set title           " Show the filename in the window titlebar.
set ttyfast         " Send more characters at a given time.
set wildchar=<TAB>  " Character for CLI expansion (TAB-completion).
set wildmenu        " Hitting TAB in command mode will show possible completions
                    " above command line.
set wrap
syntax on

" Whitespace
set backspace=indent,eol,start  " Backspace for dummies
set foldenable                  " Auto fold code
set hlsearch                    " Highlight search terms
set incsearch                   " Find as you type search
set linespace=0                 " No extra spaces between rows
set list
set listchars=tab:›\ ,trail:•,extends:#,nbsp:.    " Highlight problematic
                                                  " whitespace
set scrolljump=5                " Lines to scroll when cursor leaves screen
set scrolloff=3                 " Minimum lines to keep above and below cursor
set showmatch                   " Show matching brackets/parenthesis
set smartcase                   " Case sensitive when uc present
set whichwrap=b,s,h,l,<,>,[,]   " Backspace and cursor keys wrap too
set wildmode=list:longest,full  " Command <Tab> completion, list matches, then
                                " longest common part, then all.
set winminheight=0              " Windows can be 0 line high

set number relativenumber

" disable ugly gtk stuff
set guioptions-=M
set guioptions-=T
set guioptions-=e
set guioptions-=m

" Disable the scrollbars
set guioptions-=r
set guioptions-=L

" Enable file type detection.
" Use the default filetype settings, so that mail gets 'tw' set to 72,
" 'cindent' is on in C files, etc.
" Also load indent files, to automatically do language-dependent indenting.
filetype plugin indent on

" Put these in an autocmd group, so that we can delete them easily.
augroup vimrcEx
    au!

    " When editing a file, always jump to the last known cursor position.
    " Don't do it when the position is invalid or when inside an event handler
    " (happens when dropping a file on gvim).
    autocmd BufReadPost *
    \ if line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal g`\"" |
    \ endif
augroup END

set background=dark
if has("gui_running")
  " Only use darkocean for gvim.
  colorscheme darkocean
  let g:colors_name="darkocean"

  highlight Folded guibg=darkgreen guifg=grey

  " Try out "solarized" for a bit.  It's pretty decent at high contrast.
  "let g:solarized_contrast="high"
  "colorscheme solarized
  "set cursorline         " Looks pretty decent in solarized ^_^

  " Fits my MacVim perfectly at Twice.
  "set columns=181
  "set lines=88
else
  " Only enable highlighted cursor line for terminal vim.
  set cursorline
endif


" Various "specialty" file types.
au BufRead,BufNewFile *.bib    set nospell tw=0 cc=0
au BufRead,BufNewFile *.dart   set ft=dart
au BufRead,BufNewFile *.go     set ft=go tw=100
au BufRead,BufNewFile *.lcm    set ft=c
au BufRead,BufNewFile *.lol    set ft=lolcode
au BufRead,BufNewFile *.marko  set ft=xml
au BufRead,BufNewFile *.md     set ft=markdown tw=0
au BufRead,BufNewFile *.ss     set ft=ss
au BufRead,BufNewFile *.tex    set ft=tex tw=0

" Web Dev.
au BufRead,BufNewFile *.js     set ft=javascript tw=100
au BufRead,BufNewFile *.html   set ft=html tw=0
au BufRead,BufNewFile *.erb    set ft=mason tw=0

au BufRead,BufNewFile *.sb     set ft=c

au BufRead,BufNewFile *.go     set ft=go tw=100
au BufRead,BufNewFile *.gp     set ft=gnuplot
au BufRead,BufNewFile *.dat    set ts=8 sw=8 noet tw=0 cc=0

au BufRead,BufNewFile *.dart set ft=dart

au BufRead,BufNewFile *.log  set nospell
au BufRead,BufNewFile *.txt  set tw=0 cc=0

au BufRead,BufNewFile *.vs,*.fs set ft=glsl


" 'Highlight' text in light gray when past tw.
augroup vimrc_autocmds
  "autocmd BufEnter * highlight OverLength ctermbg=darkgrey guibg=#592929
  "autocmd BufEnter * match OverLength /\%81v.*/
  autocmd BufEnter .*\.\(tex\)\@! highlight OverLength ctermbg=darkgrey guibg=#592929
  autocmd BufEnter .*\.\(tex\)\@! match OverLength /\%81v.*/
augroup END

" OpenCog-specific syntax
if match(expand("%:p:h"), "/opencog") >= 0 && &filetype == "cpp"
  autocmd BufNewFile,BufReadPost * set ts=4 sw=4 tw=80 ff=unix cindent expandtab
endif
