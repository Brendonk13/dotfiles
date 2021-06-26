

" would be nice to test this on a diff machine but should just focus on making
" it work without errors for now



" find out how to read the vim_dotfiles_root cmd
" FIRST try just using dot and calling this file from ~/.vimrc

" Relative script_path of script file:
let s:script_path = expand('<sfile>')

" Absolute script_path of script file:
let s:script_path = expand('<sfile>:p')

" Absolute script_path of script file with symbolic links resolved:
let s:script_path = resolve(expand('<sfile>:p'))

" Folder in which script resides: (not safe for symlinks)
let s:script_path = expand('<sfile>:p:h')

" If you're using a symlink to your script, but your resources are in
" the same directory as the actual script, you'll need to do this:
"   1: Get the absolute script_path of the script
"   2: Resolve all symbolic links
"   3: Get the folder of the resolved absolute file
let s:script_path = fnamemodify(resolve(expand('<sfile>:p')), ':h')
echom s:script_path

let s:minimal_path = s:script_path . "/sourced/minimal.vim"
if filereadable(expand(s:minimal_path))
    exec "source " .  s:minimal_path
    echom 'Sourced: ' . s:minimal_path
else
    echoerr 'Could not find|read ' . s:minimal_path
endif

let s:plug_names = s:script_path . "/sourced/plug_names.vim"
if filereadable(expand(s:plug_names))
    " make sure we have a plugin manager first: vim-plug
    if empty(glob('~/.vim/autoload/plug.vim'))
        silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
            \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
        autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
    endif
    exec "source " .  s:plug_names
    echom 'Sourced: ' . s:plug_names

else
    echoerr 'Could not find|read ./sourced/plug_names.vim'
endif

" if filereadable(expand("~/.config/dotfiles/vim/autocmds"))
"     source ~/.config/dotfiles/vim/autocmds
" else
"     echoerr 'Could not find|read ~/.config/dotfiles/vim/autocmds'
" endif

" if filereadable(expand("~/.config/dotfiles/vim/autocmds"))
"     source ~/.config/dotfiles/vim/autocmds
" else
"     echoerr 'Could not find|read ~/.config/dotfiles/vim/autocmds'
" endif

" if filereadable(expand("~/.config/dotfiles/vim/autocmds"))
"     source ~/.config/dotfiles/vim/autocmds
" else
"     echoerr 'Could not find|read ~/.config/dotfiles/vim/autocmds'
" endif

