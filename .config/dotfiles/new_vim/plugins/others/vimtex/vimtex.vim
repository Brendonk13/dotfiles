
" needed to specify if .tex file is: TeX, ConTeXt, or LaTeX
let g:tex_flavor = 'latex'


" needed to have vimtex automatically go to certain lines in pdf (forward searching)
if empty(v:servername) && exists('*remote_startserver')
    call remote_startserver('VIM')
endif
let g:vimtex_quickfix_open_on_warning = 0

" I usually just copy pasta citations so don't care if they are missing fields
let g:vimtex_quickfix_ignore_filters = [
    \ 'Missing "author"',
\]

augroup Latex
    autocmd!
    " TODO: turn this into a function which opens pdf in left/right of curr i3
    " window.
    autocmd BufRead,BufNewFile *.tex compiler chktex
    " autocmd BufWrite <buffer=abuf> compiler bibertool | lmake!

    " this line was commented in og vimrc
    autocmd BufWrite *.tex Make
    " autocmd BufWritePost *.tex silent exec "Dispatch! latexmk -pdf -pvc %"
augroup END

let g:vimtex_compiler_method = 'latexmk'
let g:latex_view_general_viewer = "zathura"
let g:vimtex_view_method = "zathura"
" The quickfix window is opened automatically when there are errors,
" but it does not become the active window.
let g:vimtex_quickfix_mode = 2

if has('nvr') " use this ??
let g:vimtex_compiler_progname = 'nvr'
endif


let g:vimtex_view_forward_search_on_start = 0


" =========== conceal stuff like $...$ =========================
" One of the neosnippet plugins will conceal symbols in LaTeX which is confusing
let g:tex_conceal = ""
set conceallevel=1
let g:tex_conceal='abdmg'
" =========== conceal stuff like $...$ =========================

let g:tex_comment_nospell = 1

" Steal ideas:
" feature to highlight where a line is in pdf (shown @@ 2:50 https://www.youtube.com/watch?v=KGqrpnxoDxw)


" from: https://gist.github.com/skulumani/7ea00478c63193a832a6d3f2e661a536
" " Can hide specifc warning messages from the quickfix window
" " Quickfix with Neovim is broken or something
" " https://github.com/lervag/vimtex/issues/773
" let g:vimtex_quickfix_latexlog = {
"           \ 'default' : 1,
"           \ 'fix_paths' : 0,
"           \ 'general' : 1,
"           \ 'references' : 1,
"           \ 'overfull' : 1,
"           \ 'underfull' : 1,
"           \ 'font' : 1,
"           \ 'packages' : {
"           \   'default' : 1,
"           \   'natbib' : 1,
"           \   'biblatex' : 1,
"           \   'babel' : 1,
"           \   'hyperref' : 1,
"           \   'scrreprt' : 1,
"           \   'fixltx2e' : 1,
"           \   'titlesec' : 1,
"           \ },
"           \}
