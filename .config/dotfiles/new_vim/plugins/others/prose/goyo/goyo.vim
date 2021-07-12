
autocmd! User GoyoEnter nested call <SID>goyo_enter()
autocmd! User GoyoLeave nested call <SID>goyo_leave()

function! s:goyo_enter()
  setlocal noshowmode
  setlocal noshowcmd
  setlocal scrolloff=999

  " I use goyo/limelight for prose, this helps it work as a checklist
  nnoremap <buffer> dx mt0r🗹 <ESC>`t
  nnoremap <buffer> dy mtI☐  <ESC>`tW
  Limelight
  " ...
endfunction

function! s:goyo_leave()
  " setlocal showmode
  setlocal showcmd
  setlocal scrolloff=1
  nunmap <buffer> dx
  Limelight!
  " ...
endfunction

