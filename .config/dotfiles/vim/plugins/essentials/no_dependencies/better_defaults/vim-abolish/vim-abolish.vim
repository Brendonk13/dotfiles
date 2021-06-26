if !filereadable(expand("~/.vim/after/plugin/abolish.vim"))
    echoerr 'Loading abolishes FAILED. expected abolishes to be in non-existant file: ~/.vim/after/plugin/abolish.vim'
endif


" Abolishes in that file:

    " Abolish recieve{d,r,s} receive{}
    " Abolish recieving      receiving
