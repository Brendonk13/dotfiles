augroup Git
  autocmd!
  " delete fugitive buffers to avoid clogging buffer list.
  autocmd BufReadPost fugitive://* set bufhidden=delete
augroup END

