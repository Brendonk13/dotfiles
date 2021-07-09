set nocompatible
syntax on

" ======== Get path where this file lies =============
" Relative base_path of script file:
let s:base_path = expand('<sfile>')

" Absolute base_path of script file:
let s:base_path = expand('<sfile>:p')

" Absolute base_path of script file with symbolic links resolved:
let s:base_path = resolve(expand('<sfile>:p'))

" Folder in which script resides: (not safe for symlinks)
let s:base_path = expand('<sfile>:p:h')

" If you're using a symlink to your script, but your resources are in
" the same directory as the actual script, you'll need to do this:
"   1: Get the absolute base_path of the script
"   2: Resolve all symbolic links
"   3: Get the folder of the resolved absolute file
let s:base_path = fnamemodify(resolve(expand('<sfile>:p')), ':h')


function SourceFile(local_path)
    " let l:base_path = GetFilePath()
    let l:path = s:base_path . a:local_path
    if filereadable(expand(l:path))
        exec "source " .  l:path
        " echom 'Sourced: ' . l:path
    else
        echoerr 'Could not find|read ' . l:path
    endif
endfunction

function LoadPlugins(plug_path)
    " let l:base_path = GetFilePath()
    let l:plug_names = s:base_path . a:plug_path
    if filereadable(expand(l:plug_names))
        " make sure we have a plugin manager first: vim-plug
        if empty(glob('~/.vim/autoload/plug.vim'))
            silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
                \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
            autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
        endif
        exec "source " .  l:plug_names
        " echom 'Sourced: ' . l:plug_names
    else
        echoerr 'Could not find|read ./sourced/plug_names.vim'
    endif

endfunction

" echom 'base path is: ' . s:base_path



" ================ source files ============================
call LoadPlugins("/sourced/plug_names.vim")

" This is done in the vimrc.vim in root since it changes other highlights if
" done after them
if filereadable(expand("$HOME/.vim/plugged/vim-solarized/colors/solarized.vim") )
    set background=dark
    colorscheme solarized
    " this allows for usage of truecolor !
    set termguicolors
    set t_Co=256
    " NOTE: will have to do some checks here to see if the terminal supports 256
    " colors !!!!
endif

" call SourceFile("/sourced/minimal.vim")
call SourceFile("/sourced/common.vim")
call SourceFile("/sourced/dev.vim")
call SourceFile("/sourced/desktop.vim")
" syntax enable -- screws up quickscope colors if done before this
" But pinnacle needs it on to make highlights
" syntax on
call SourceFile("/sourced/minimal.vim")
" highlight SignColumn guibg=bg
" highlight SignColumn ctermbg=bg
doautocmd Syntax
