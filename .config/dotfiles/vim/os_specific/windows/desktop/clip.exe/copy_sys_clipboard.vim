
"from: https://stackoverflow.com/questions/44480829/how-to-copy-to-clipboard-in-vim-of-bash-on-windows
" just calls the native windows clip.exe function nice n simple
func! GetSelectedText()
  normal! gv"ty
  let result = getreg("t")
  return result
endfunc

"this is used by WSL
if executable("clip.exe")
  echom "clip.exe is executable"
  noremap <silent><leader>y :call system('clip.exe', GetSelectedText())<CR>
  " could/should add a cut command but who cares
  "noremap <C-X> :call system('clip.exe', GetSelectedText())<CR>gvx
endif
