
"           note that <CR> by itself is not used in normal mode!!!
"-- here do: map <expr> <CR> empty(&buftype) ? '@@' : '<CR>'
" so that <CR> works on special buffers like qf window!!
" --- use the replay plugin if ever map <CR> @@

"another dece one is <S-Tab>
" also d<CR> and most char<CR> combos are free space!!
" look into the usefulness of current K command!
" currently never use U, and replace mode is replacable
" the Z cmd not used, but theres a delay when mapping cuz of ZZ cmd
" would be sickkk if i could get rid of that delay (kinda)




" need to map something to save a file and then swithc down buffers to a
" terminal and enter it as well
"nnoremap 


" http://learnvimscriptthehardway.stevelosh.com/chapters/15.html\   has nice operator pending maps 
" https://medium.com/@sidneyliebrand/a-collection-of-vim-key-binds-4d227c9a455


" would be nice to have a drop down general use terminal for traversing purposes
" was thinking it would be nice to have one per tab
"nnoremap <silent>,<CR> :call ()<cr>
