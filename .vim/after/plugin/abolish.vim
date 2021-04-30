" Exit if :Abolish isn't available.
if !exists(':Abolish')
    finish
endif

" ~/.vim/after/plugin/abolish.vim
" must be its own file for some reason

Abolish recieve{d,r,s} receive{}
Abolish recieving receiving

Abolish percieve{d,s} perceive{}
