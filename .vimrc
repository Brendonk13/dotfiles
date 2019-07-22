" 1st 3 cmd's allow: all runtime files and packages in ~/.vim will be loaded by Neovim.
" Any customisations you make in your ~/.vimrc will now apply to Neovim as
" well as Vim. ---- from http://vimcasts.org/episodes/meet-neovim/

set nocompatible
" , means the dir in which vim was opened, '.' means the directory of the file where the cursor is
set path=.,,,~/,~/vimCommands,~/dotfiles/**,~/PyShit/**,
" now these types don't appear in wild menu options
set wildignore=*.o,*.a,*.so,*.pyc,*.swp,.git/*,*.class,~/FromInternet/*,*.dll,~/.vim_black/*,*pycache*
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
" for security reasons
set nomodeline

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

"set formatoptions+=j     " Delete comment character when joining commented lines
set cursorline                        " highlight current line
set linebreak               " don't wrap line mid-word

set list
set listchars=trail:Δ

" show matching bracket for 3 seconds
set matchtime=3

" tree view!
let g:netrw_liststyle=3

" didnt't seem to do anything...
"set showcmd            " show cmd in status line
"set noshowmode          " now the insert shit doesnt show at bottom, have vim airline now!
set ignorecase          " case insensitive search by default
set smartcase           " override ignorecase if capital entered mid search
set incsearch           " jump to candidates while typing search pattern
set gdefault            " assume the /g flag on :s substitutions to replace all matches in a line

if filereadable(expand("~/.vimPlug/vimPlugCall"))
    source ~/.vimPlug/vimPlugCall
endif
" source those keyboard mappings  
" how can I move this file to diff folder and make it work with git?
if filereadable(expand("~/dotfiles/.vim_mappings"))
    source ~/dotfiles/.vim_mappings
endif
" source vim command file
if filereadable(expand("~/dotfiles/vimm/.vim_commands"))
    source ~/dotfiles/vimm/.vim_commands
endif

let g:python3_host_prog='/usr/bin/python3.6'

"highlight Cursor cterm=underline gui=underline term=underline

"autocmd ColorScheme * highlight Comment cterm=underline gui=underline term=underline -- Needs to be before colorscheme set

set termguicolors        " this allows for usage of truecolor !
set t_Co=256
let g:solarized_bold=1
let g:solarized_italic=1
syntax enable
set background=dark
colorscheme solarized

" accidently deleted a file today, now I have vim version control!!
set undodir=~/.vim/tmp/undo
set undofile

" use ripgrep instead of grep
set grepprg=rg

" these settings don't autocomplete my omni-complete till i press enter!
" yes enter, i have a mapping to use this instead of <C-y>
set completeopt=longest,menuone,preview

