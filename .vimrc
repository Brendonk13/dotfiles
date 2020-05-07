set nocompatible
"default for nvim, but who knows about elsewhere..
set encoding=utf-8
" , means the dir in which vim was opened, '.' means the directory of the file where the cursor is
set path=.,,,~/,~/Notes/vim-notes,~/dotfiles/**,~/PyStuff/morsels,~/.i3,~/.vimPlug/**,~/Scripts/

" add compiler assignment path
set path+=~/Documents/Mcgill/5th-year/Winter/Compilers/goLite/2020_group11/**
" add java assignment path
set path+=~/Downloads/programs/eclipse-workspace/Comp409A1/src/

" now these types don't appear in wild menu options
set wildignore=*.o,*.a,*.so,*.pyc,*.swp,.git/*,*.class,~/FromInternet/*,*.dll,~/.vim_black/,~/.vim_black/**~/.vim_black,*pycache*,*.cmi,*.cmo,*.cmx,*.mli,*.depends,*.native,_build/*
" whhyyyy can't I get .vim_black to not appear in wildignore!!
" note that frominternet appears as well!!!

" jump to window if searching for file in one of this sessions windows
" for quickfix window only
set switchbuf=usetab

" show fold numbering on the side
" set foldcolumn=0

set shortmess+=c

set mouse=a
set mousemodel=popup

" when set, occasionally got weird err's (maybe to do with wsl)
"set clipboard=unnamedplus      "need to check if this/leader>y both work on server!

set wildignorecase

"longest makes it so that tab completes to longest common substring of matches
"which appear in wildmenu produced by full portion.
" generally, wildmode tells wildmenu how to behave
set wildmode=longest:full
set autoread              " re-read file into buffer if disk version changed while vim's open
" the splits feel more natural this way 
set splitright
set splitbelow
" disables redrawing screen while executing macros -- faster macro execution
set lazyredraw

" for security reasons
set nomodeline

" allow :bn instead of :bn! for swapping a hidden buffer to buffer list
set hidden
" autoindent: indent when enter pressed in insert, indent with o,O in normal
set autoindent
" This doesn't seem to add anything strangely ..
set backspace=indent,eol,start
" tabs take up 4 spaces
set tabstop=4
" now, pressing tab key inserts spaces automatically
set expandtab
" shift width is how much a line is shifted by when >> is pressed (in normal mode)
set shiftwidth=4
" deletes expanded tab in 1 backspace
set softtabstop=4
" round up tabs to always be multiple of 4
set shiftround

"set relativenumber         " line #'s are relative to cursor position, good for small jumps
"set nu                     " having both on shows line # instead of 0 for cursor line
set laststatus=2

" cursor now only goes within 1 line of top/bottom
set scrolloff=1

"set formatoptions+=j     " Delete comment character when joining commented lines
"allows smart indenting for numbered lists
set formatoptions+=n
" highlight current line
set cursorline
" " don't wrap line mid-word
if has('linebreak')
    set linebreak
  let &showbreak='⤷ '                 " ARROW POINTING DOWNWARDS THEN CURVING RIGHTWARDS (U+2937, UTF-8: E2 A4 B7)
endif

if has('virtualedit')
    "idk how to explain, nice for visual block mode
    set virtualedit=block
endif

set list
set listchars=trail:•
set listchars+=tab:▷┅
"U25B7 then U2505

" show matching bracket for 3 seconds -- not working, check ben orenstein's rc
" for other cmd before this one
set matchtime=3
" this don't work currently ...

" tree view!
let g:netrw_liststyle=3

" now the insert shit doesnt show at bottom, have vim lightline now!
set noshowmode
" case insensitive search by default
set ignorecase
" override ignorecase if capital entered mid search
set smartcase
" jump to candidates while typing search pattern
set incsearch
" assume the /g flag on :s substitutions to replace all matches in a line
set gdefault


if filereadable(expand("~/.vimPlug/vimPlugCall"))
    source ~/.vimPlug/vimPlugCall
else
    echoerr 'could not find|read ~/.vimPlug/vimPlugCall'
endif

if filereadable(expand("~/.vimPlug/plugSettings"))
    source ~/.vimPlug/plugSettings
else
    echoerr 'could not find|read ~/.vimPlug/plugSettings'
endif


" source those keyboard mappings
" how can I move this file to diff folder and make it work with git?
if filereadable(expand("~/dotfiles/.vim_mappings"))
    source ~/dotfiles/.vim_mappings
else
    echoerr 'could not find|read ~/dotfiles/.vim_mappings'
endif
" source vim command file
if filereadable(expand("~/dotfiles/vimm/.vim_commands"))
    source ~/dotfiles/vimm/.vim_commands
else
    echoerr 'could not find|read ~/dotfiles/vimm/.vim_mappings'
endif

" NOTE: that I source autocmd's at bottom of file (need highlights done after
" loading colorscheme.



" note that rpy runs anacondas py3.7 -- also has readline
"let g:python3_host_prog='/usr/bin/python3.6'
let g:python3_host_prog='/usr/bin/python'



" this allows for usage of truecolor !
set termguicolors
set t_Co=256
let g:solarized_bold=1
let g:solarized_italic=1
" syntax enable
syntax on
set background=dark
colorscheme solarized

" sets vertical split to be a bar
set fillchars+=vert:│
highlight VertSplit ctermbg=NONE guibg=NONE

set signcolumn=yes
highlight SignColumn guibg=bg
highlight SignColumn ctermbg=bg

" set status line divider for inactive windows
" TODO: create a function which will only draw these ~'s if the window is on
" top and there exists a horizontal split
" do this using winwidth(), winheight() total_num_wins = winnr('$'), and screencol()/screenrow()
" map out where the window is to see if the bottom row is at &lines (then we
" are on top window)
" https://stackoverflow.com/questions/8070850/get-position-of-splitted-windows-on-a-vim-editor
set fillchars+=stlnc:~
highlight StatusLineNC ctermbg=NONE guibg=NONE

" use ripgrep instead of grep
set grepprg=rg


" these settings don't autocomplete my omni-complete till i press enter!
" yes enter, i have a mapping to use this instead of <C-y>
set completeopt=longest,menuone,preview
highlight Pmenu ctermbg=238 gui=bold
" This color is similar to my background color, I like it better


" this sets a red cursor for terminal mode!
highlight TermCursor ctermfg=red guifg=red

" accidently deleted a file today, now I have vim version control!!
if has('persistent_undo')
    if exists('$SUDO_USER')
        set noundofile
    else
        set undodir=~/.vim/tmp/undo
        set undodir+=~/local/.vim/tmp/undo
        set undodir+=.
        " actually turn on undofiles
        set undofile
    endif
endif

" root user created backups mean that non root's can no longer access backups
if exists('$SUDO_USER')
    set nobackup
    set nowritebackup
else
    if isdirectory(expand('$HOME/.vim/tmp/backup'))
        set backupdir=$HOME/.vim/tmp/backup
    else
        echoerr 'warning: $HOME/.vim/tmp/backup is not a directory, now writing backups elsewhere'
        set backupdir+=~/local/.vim/tmp/backup
        set backupdir+=.
        " if first option doesn't exist, write to current directory
    endif
endif

" note i can eliminate swap files from my life with wincent/terminus
" or the plugin made by damian conway listed in potential plugin file
" don't allow root to create swap files to avoid similar headaches
if exists('$SUDO_USER')
    set noswapfile
else
    set directory=$HOME/.vim/tmp/backup//
    set directory+=~/local/.vim/tmp/backup//
    set directory+=.
    " if first option doesn't exist, write to current directory
endif

" nvim uses shada not viminfo, can find full details of setting
" this up in settings pt 3
"
"if has('viminfo')                        " nvim uses shada, here for portability
"  if exists('$SUDO_USER')
"    set viminfo=                         " don't create root owned files, other users can't use them after root has touched them
"  else
"    if isdirectory('~/.vim/tmp')
"      set viminfo+=n~/.vim/tmp



if filereadable(expand("~/dotfiles/vimm/.my_autocmds"))
    source ~/dotfiles/vimm/.my_autocmds
else
    echoerr 'Could not find|read ~/dotfiles/vimm/.my_autocmds'
endif






if exists('&belloff')
" bells bad!
  set belloff=all
endif
