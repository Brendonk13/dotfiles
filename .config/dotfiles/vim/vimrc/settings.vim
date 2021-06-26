set nocompatible

" ================= QOL improvements =========================================
set wildignore=*.o,*.a,*.so,*.pyc,*.swp,.git/*,*.class,*.dll,~/.vim_black/,~/.vim_black/**~/.vim_black,*pycache*,*.cmi,*.cmo,*.cmx,*.mli,*.depends,*.native,_build/*
set wildignorecase
set wildmode=longest:full

"default for nvim, but who knows about elsewhere..
set encoding=utf-8
set autoread              " re-read file into buffer if disk version changed while vim's open

set shortmess+=c

" disables redrawing screen while executing macros -- faster macro execution
set lazyredraw

" for security reasons
set nomodeline

" allow :bn instead of :bn! for swapping a hidden buffer to buffer list
set hidden

" I. will. not. capitalize.
set spellcapcheck=

" only show top 5 suggestions, never going to look through more options
set spellsuggest=fast,5

if exists('&belloff')
" bells bad!
  set belloff=all
endif

" ================= Aesthetics =========================================
set laststatus=2

set formatoptions+=n
" highlight current line
set cursorline
" " don't wrap line mid-word
if has('linebreak')
    set linebreak
  let &showbreak='  ⤷ '                 " ARROW POINTING DOWNWARDS THEN CURVING RIGHTWARDS (U+2937, UTF-8: E2 A4 B7)
endif


" cursor now only goes within 1 line of top/bottom
set scrolloff=1

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

set matchtime=3

" tree view!
let g:netrw_liststyle=3

" now the insert shit doesnt show at bottom, have vim lightline now!
set noshowmode


" ================================================================================================
" this allows for usage of truecolor !
set termguicolors
set t_Co=256
" NOTE: will have to do some checks here to see if the terminal supports 256
" colors !!!!
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
" ================================================================================================





" syntax enable
syntax on

" sets vertical split to be a bar
set fillchars+=vert:│
highlight VertSplit ctermbg=NONE guibg=NONE

if has("patch-8.1.1564")
  " Recently vim can merge signcolumn and number column into one
  set signcolumn=number
else
  set signcolumn=yes
endif

set fillchars+=stlnc:~
highlight StatusLineNC ctermbg=NONE guibg=NONE


" Don't show URL's as incorrectly spelled
syn match UrlNoSpell "\w\+:\/\/[^[:space:]]\+" contains=@NoSpell

" these settings don't autocomplete my omni-complete till i press enter!
" yes enter, i have a mapping to use this instead of <C-y>
set completeopt=longest,menuone,preview
highlight Pmenu ctermbg=238 gui=bold
" This color is similar to my background color, I like it better


" ================= usability ================================================
set switchbuf=usetab

set mouse=a
set mousemodel=popup

" the splits feel more natural this way 
set splitright
set splitbelow

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

" case insensitive search by default
set ignorecase
" override ignorecase if capital entered mid search
set smartcase
" jump to candidates while typing search pattern
set incsearch
" assume the /g flag on :s substitutions to replace all matches in a line
set gdefault


let g:python3_host_prog='/usr/bin/python'

