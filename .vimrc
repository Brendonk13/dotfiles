
" if filereadable(expand("~/.config/dotfiles/vim/vimrc.vim"))
"     source ~/.config/dotfiles/vim/vimrc.vim
" else
"     echoerr 'Could not find|read ~/.config/dotfiles/vim/vimrc.vim'
" endif


set nocompatible

" only show top 5 suggestions, never going to look through more options
set spellsuggest=fast,5




"default for nvim, but who knows about elsewhere..
set encoding=utf-8
" , means the dir in which vim was opened, '.' means the directory of the file where the cursor is
" set runtimepath+=/home/brendon/new_dotfiles/vim/plugins/remote/better_defaults/vim-abolish/abolishes.vim
set path+=.,,,~/,~/Notes/vim-notes,~/.config/dotfiles/**,~/PyStuff/morsels,~/.i3,~/.vimPlug/**,~/Scripts/

" now these types don't appear in wild menu options
set wildignore=*.o,*.a,*.so,*.pyc,*.swp,.git/*,*.class,~/FromInternet/*,*.dll,~/.vim_black/,~/.vim_black/**~/.vim_black,*pycache*,*.cmi,*.cmo,*.cmx,*.mli,*.depends,*.native,_build/*

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
  let &showbreak='  ⤷ '                 " ARROW POINTING DOWNWARDS THEN CURVING RIGHTWARDS (U+2937, UTF-8: E2 A4 B7)
endif

" wow this is great, lines wrap at same indentation as previous line
set breakindent

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

if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

if filereadable(expand("~/.config/dotfiles/old_vim/plugins/vimPlugCall"))
    source ~/.config/dotfiles/old_vim/plugins/vimPlugCall
else
    echoerr 'could not find|read ~/.config/dotfiles/old_vim/plugins/vimPlugCall'
endif

if filereadable(expand("~/.config/dotfiles/old_vim/plugins/plugSettings"))
    source ~/.config/dotfiles/old_vim/plugins/plugSettings
else
    echoerr 'could not find|read  ~/.config/dotfiles/old_vim/plugins/plugSettings'
endif


if filereadable(expand("~/.config/dotfiles/old_vim/autocmds"))
    source ~/.config/dotfiles/old_vim/autocmds
else
    echoerr 'Could not find|read ~/.config/dotfiles/old_vim/autocmds'
endif




" source those keyboard mappings
" how can I move this file to diff folder and make it work with git?
if filereadable(expand("~/.config/dotfiles/old_vim/mappings"))
    source ~/.config/dotfiles/old_vim/mappings
else
    echoerr 'could not find|read ~/.config/dotfiles/old_vim/mappings'
endif
" source vim command file
if filereadable(expand("~/.config/dotfiles/old_vim/commands"))
    source ~/.config/dotfiles/old_vim/commands
else
    echoerr 'could not find|read ~/.config/dotfiles/old_vim/commands'
endif

" NOTE: that I source autocmd's at bottom of file (need highlights done after
" loading colorscheme.



" note that rpy runs anacondas py3.7 -- also has readline
"let g:python3_host_prog='/usr/bin/python3.6'
let g:python3_host_prog='/usr/bin/python'



" this allows for usage of truecolor !
set termguicolors
set t_Co=256

" Fix using different colorscheme in terminal mode (was hard to read the old colors)
" use terminal's colorscheme in terminal mode: https://github.com/neovim/neovim/issues/2897
let g:terminal_color_0 = '#000000'
let g:terminal_color_8 = '#545454'
let g:terminal_color_1 = '#ff0000'
let g:terminal_color_9 = '#f40d17'
let g:terminal_color_2 = '#37dd21'
let g:terminal_color_10 = '#3bcf1d'
let g:terminal_color_3 = '#fee409'
let g:terminal_color_11 = '#ecc809'
let g:terminal_color_4 = '#1460d2'
let g:terminal_color_12 = '#5555ff'
let g:terminal_color_5 = '#ff005d'
let g:terminal_color_13 = '#ff55ff'
let g:terminal_color_6 = '#00bbbb'
let g:terminal_color_14 = '#6ae3f9'
let g:terminal_color_7 = '#bbbbbb'
let g:terminal_color_15 = '#ffffff'


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


" Don't show URL's as incorrectly spelled
syn match UrlNoSpell "\w\+:\/\/[^[:space:]]\+" contains=@NoSpell
" I. will. not. capitalize.
set spellcapcheck=


" use ripgrep instead of grep
set grepprg=rg


" these settings don't autocomplete my omni-complete till i press enter!
" yes enter, i have a mapping to use this instead of <C-y>
set completeopt=longest,menuone,preview
highlight Pmenu ctermbg=238 gui=bold
" This color is similar to my background color, I like it better


" this sets a red cursor for terminal mode!
highlight TermCursor ctermfg=red guifg=red

" ------------ SETUP UNDO ------------------------------------------
if has('persistent_undo')
    if exists('$SUDO_USER')
        set noundofile
    else
        if !isdirectory(expand('$HOME/.vim/tmp/undo'))
            silent !mkdir -p $HOME/.vim/tmp/undo
            echoerr 'Created directory: $HOME/.vim/tmp/undo since it did not exist'
        endif
        set undodir=~/.vim/tmp/undo
        " actually turn on undofiles
        set undofile
    endif
endif

" ------------ SETUP BACKUPS -------------------------------------------
" root user created backups mean that non root's can no longer access backups
if exists('$SUDO_USER')
    set nobackup
    set nowritebackup
else
    if !isdirectory(expand('$HOME/.vim/tmp/backup'))
        silent !mkdir -p $HOME/.vim/tmp/backup
        echoerr 'Created directory: $HOME/.vim/tmp/backup since it did not exist'
    endif
    set backupdir=$HOME/.vim/tmp/backup
    " if first option doesn't exist, write to current directory
endif

" note i can eliminate swap files from my life with wincent/terminus
" or the plugin made by damian conway listed in potential plugin file
" don't allow root to create swap files to avoid similar headaches
" ------------ SETUP SWAPFILE ------------------------------------------
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


" if filereadable(expand("~/.config/dotfiles/vim/autocmds"))
"     source ~/.config/dotfiles/vim/autocmds
" else
"     echoerr 'Could not find|read ~/.config/dotfiles/vim/autocmds'
" endif

if exists('&belloff')
" bells bad!
  set belloff=all
endif

highlight Folded guibg=NONE guifg=LightGray



" if filereadable(expand("~/.vimPlug/vimPlugCall"))
"     source ~/.vimPlug/vimPlugCall
" else
"     echoerr 'could not find|read ~/.vimPlug/vimPlugCall'
" endif

" if filereadable(expand("~/.vimPlug/plugSettings"))
"     source ~/.vimPlug/plugSettings
" else
"     echoerr 'could not find|read ~/.vimPlug/plugSettings'
" endif


" " source those keyboard mappings
" " how can I move this file to diff folder and make it work with git?
" if filereadable(expand("~/.config/dotfiles/vim/mappings"))
"     source ~/.config/dotfiles/vim/mappings
" else
"     echoerr 'could not find|read ~/.config/dotfiles/vim/mappings'
" endif
" " source vim command file
" if filereadable(expand("~/.config/dotfiles/vim/commands"))
"     source ~/.config/dotfiles/vim/commands
" else
"     echoerr 'could not find|read ~/.config/dotfiles/vim/commands'
" endif

