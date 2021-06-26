
" TODO: turn this into a function which opens pdf in left/right of curr i3
" window.
" autocmd BufDelete *.tex call <SID>deleteLatexGarb()
autocmd! BufWritePost *.tex silent exec "Dispatch! latexmk -pdf -pvc %"

" function! s:deleteLatexGarb()
"     let fil = "Dispatch! latexmk -c l:fil" . "expand('<afile>')"
"     silent execute fil
" endfunction

