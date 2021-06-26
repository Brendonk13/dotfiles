augroup CommentString
  autocmd!
  autocmd Filetype ocaml setlocal commentstring=(*\ %s\ *)
  autocmd Filetype cs setlocal commentstring=//\ %s
  autocmd FileType markdown setlocal commentstring=[//]:\ #\ (%s)
augroup END
