" 1st 3 cmd's allow: all runtime files and packages in ~/.vim will be loaded by Neovim.
" Any customisations you make in your ~/.vimrc will now apply to Neovim as
" well as Vim. ---- from http://vimcasts.org/episodes/meet-neovim/

set nocompatible
set encoding=utf-8     "default for nvim, but who knows about elsewhere..
" , means the dir in which vim was opened, '.' means the directory of the file where the cursor is
set path=.,,,~/,~/vim-notes,~/dotfiles/**,~/PyStuff/morsels,~/.i3,~/.vimPlug/**,~/Scripts/
" now these types don't appear in wild menu options
set wildignore=*.o,*.a,*.so,*.pyc,*.swp,.git/*,*.class,~/FromInternet/*,*.dll,~/.vim_black/,~/.vim_black/**~/.vim_black,*pycache*
" whhyyyy can't I get .vim_black to not appear in wildignore!!
" note that frominternet appears as well!!!

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
set lazyredraw            " disables redrawing screen while executing macros -- faster macro execution

set nomodeline            " for security reasons

set hidden                " allow :bn instead of :bn! for swapping a hidden buffer to buffer list
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

set relativenumber         " line #'s are relative to cursor position, good for small jumps
set nu                     " having both on shows line # instead of 0 for cursor line
set laststatus=2

" cursor now only goes within 1 line of top/bottom
set scrolloff=1

"set formatoptions+=j     " Delete comment character when joining commented lines
set formatoptions+=n        "allows smart indenting for numbered lists
set cursorline                        " highlight current line
set linebreak               " don't wrap line mid-word

if has('virtualedit')
    "idk how to explain, nice for visual block mode
    set virtualedit=block
endif

set list
set listchars=trail:•
set listchars+=tab:▷┅
"U25B7 then U2505



" see :h fillchars
"set fillchars=stl:─,stlnc:─,vert:│
"set fillchars=vert:|


" show matching bracket for 3 seconds -- not working, check ben orenstein's rc
" for other cmd before this one
set matchtime=3
" this don't work currently ...

" tree view!
let g:netrw_liststyle=3

" didnt't seem to do anything...
"set showcmd            " show cmd in status line
set noshowmode          " now the insert shit doesnt show at bottom, have vim airline now!
set ignorecase          " case insensitive search by default
set smartcase           " override ignorecase if capital entered mid search
set incsearch           " jump to candidates while typing search pattern
set gdefault            " assume the /g flag on :s substitutions to replace all matches in a line

if filereadable(expand("~/.vimPlug/vimPlugCall"))
    source ~/.vimPlug/vimPlugCall
else
    echoerr 'could not find|read ~/.vimPlug/vimPlugCall'
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

if filereadable(expand("~/dotfiles/vimm/.my_autocmds"))
    source ~/dotfiles/vimm/.my_autocmds
else
    echoerr 'Could not find|read ~/dotfiles/vimm/.my_autocmds'
endif




" note that rpy runs anacondas py3.7 -- also has readline
"let g:python3_host_prog='/usr/bin/python3.6'
let g:python3_host_prog='/usr/bin/python'

"highlight Cursor cterm=underline gui=underline term=underline

"autocmd ColorScheme * highlight Comment cterm=underline gui=underline term=underline -- Needs to be before colorscheme set

set termguicolors        " this allows for usage of truecolor !
set t_Co=256
let g:solarized_bold=1
let g:solarized_italic=1
set background=dark
syntax enable
colorscheme solarized

" use ripgrep instead of grep
set grepprg=rg


"highlight CursorLineNr gui=bold guifg=238
"I find this slightly distracting, I care more about seeing relative #'s


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
        set undofile             " actually turn on undofiles
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


if exists('&belloff')
  set belloff=all                       " bells bad!
endif
