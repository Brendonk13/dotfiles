" 1st 3 cmd's allow: all runtime files and packages in ~/.vim will be loaded by Neovim.
" Any customisations you make in your ~/.vimrc will now apply to Neovim as
" well as Vim. ---- from http://vimcasts.org/episodes/meet-neovim/

set nocompatible
set path+=**              " allows for fuzzy file finding if autochdir is off! 
" now these types don't appear in wild menu options
set wildignore=*.o,*.a,*.so,*.pyc,*.swp,.git/*,*.class 
set autoread              " re-read file into buffer if disk version changed while vim's open
" the splits feel more natural this way 
set splitright
set splitbelow           
set lazyredraw            " redraw screen less often or something

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

set relativenumber         " line #'s are relative to cursor position, good for small jumps
set nu                     " having both on shows line # instead of 0 for cursor line
set laststatus=2

set termguicolors        " this allows for usage of truecolor !
"set formatoptions+=j     " Delete comment character when joining commented lines
set cursorline                        " highlight current line
set linebreak               " don't wrap line mid-word

" didnt't seem to do anything...
"set showcmd            " show cmd in status line
set noshowmode          " now the insert shit doesnt show at bottom, have vim airline now!
set ignorecase          " case insensitive search by default
set smartcase           " override ignorecase if capital entered mid search
set incsearch           " jump to candidates while typing search pattern

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


set t_Co=256
syntax enable
set background=dark
colorscheme solarized

" from https://thoughtbot.com/blog/faster-grepping-in-vim 
 if executable('ag')
     "Use ag over grep
     set grepprg=ag\ --nogroup\ --nocolor
     command -nargs=+ -complete=file -bar Ag silent! grep! <args>|cwindow|redraw!
     " map Ag to backslash!
     nnoremap \ :Ag<SPACE>
endif


" send signal called Osc52 escape sequence to any 64 bit OS to copy from vim to clipboard
" first we base64 encode the yanked register: @0
"function! Osc52Yank()
"    let buffer=system('base64 -w0', @0)  " -w0 to disable 76 char line wrapping 
"    let buffer='\ePtmux;\e\e]52;c;'.buffer.'\x07\e\\'
"    silent exe "!echo -ne ".shellescape(buffer)." > ".shellescape(/dev/tty)
"endfunction 
"
"function! Osc52Yank()
"    let buffer=system('base64 -w0', @0)
"    let buffer=substitute(buffer, "\n$", "", "")
"    let buffer='\e]52;c;'.buffer.'\x07'
"    silent exe "!echo -ne ".shellescape(buffer)." > ".shellescape("/dev/tty")
"endfunction
"command! Osc52CopyYank call Osc52Yank()
"augroup Example
"    autocmd!
"    autocmd TextYankPost * if v:event.operator ==# 'y' | call Osc52Yank() | endif
"augroup END
"
""nnoremap <leader>y :call Osc52Yank()<CR>
"nnoremap <leader>y Osc52CopyYank
"
