
" find out how to read the vim_dotfiles_root cmd
" FIRST try just using dot and calling this file from ~/.vimrc

if filereadable(expand("./sourced/minimal.vim"))
    source ~/.config/dotfiles/vim/autocmds
else
    echoerr 'Could not find|read sourced/minimal.vim'
endif

if filereadable(expand("./sourced/plug_names.vim"))
    source ~/.config/dotfiles/vim/autocmds
else
    echoerr 'Could not find|read sourced/plug_names.vim'
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

