function! CdIfNeed()
    silent! cd %:p:h | silent! cd `git rev-parse --show-toplevel`
endfunction


command! -bang -nargs=* GGrep
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always --colors "path:fg:190,220,255" --colors "line:fg:128,128,128" --smart-case '.shellescape(<q-args>), 0,
  \   fzf#vim#with_preview({'dir': systemlist('git rev-parse --show-toplevel')[0]}), <bang>0)

nnoremap <silent> <leader><M-f> :call CdIfNeed()<CR>:GFiles<CR>

" nnoremap <silent> <leader><M-r> :GGrep<CR>
nnoremap <silent> <leader><M-r> :call CdIfNeed()<CR><bar>:RG<CR>
