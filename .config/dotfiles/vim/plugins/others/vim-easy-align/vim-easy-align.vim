" NOTE: much easier to just align using regex than adding a delimeter.
" EasyAlign /->/

let g:easy_align_delimiters = {
  \ ';': { 'pattern': ';', 'left_margin': 0, 'stick_to_left': 1 } }


xmap <leader>ga <Plug>(EasyAlign)

" this allows for easy alignment based on searching
xmap ga :EasyAlign //<left>

" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

" nmap <leader>ga :EasyAlign

