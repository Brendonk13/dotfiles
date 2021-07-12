
" this visually selects most recent paste/insert mode session
nnoremap gV `[v`]

" allow '.' and '@' to work in VISUAL MODE
" note these don't work with recursive macros, v tempted to get wincent's
" plugin which reassigns <CR> to @@ but runs most recently created OR recently used AND works with recursive macros
vnoremap . :norm .<CR>
vnoremap Q :norm @@<CR>
" added this plugin just now in new dotfiles


" keep selection after shifting
vnoremap < <gv
vnoremap > >gv

" move down a line regardless of wrapping
vnoremap j gj
vnoremap k gk

