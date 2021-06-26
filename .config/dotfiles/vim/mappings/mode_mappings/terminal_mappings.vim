
" if has('nvim')
if exists(':terminal')

  " so for some reason these alt mappings don't work consistently
  " but working so far for escaping terminal mode, can delete others probly
  tnoremap <M-[> <C-\><C-n>
  " using meta key allows for the esc key to work in terminal mode still

  " Terminal mode:
  tnoremap <M-h> <c-\><c-n><c-w>h
  tnoremap <M-j> <c-\><c-n><c-w>j
  tnoremap <M-k> <c-\><c-n><c-w>k
  tnoremap <M-l> <c-\><c-n><c-w>l

  " currently don't even use nu, rnu but may as well keep.
  augroup term
  autocmd!
  autocmd TermOpen * setlocal nonumber norelativenumber
  augroup END

  "should probly change these to <leader>__t to be consistent with my other normal mode splits
  nnoremap <silent> <leader>wt :terminal<CR>i
  nnoremap <silent> <leader>vt :vs<bar>:terminal<CR>i
  nnoremap <silent> <leader>st :sp<bar>:terminal<CR>i
  nnoremap <silent> <leader>tt :tabnew<bar>:terminal<CR>i

    " this sets a red cursor for terminal mode!
    highlight TermCursor ctermfg=red guifg=red

endif
