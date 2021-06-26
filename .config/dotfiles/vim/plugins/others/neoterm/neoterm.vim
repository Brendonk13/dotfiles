

" note winfixheight option used by neoterm_fixedsize
" let g:neoterm_term_per_tab = 1
" let g:neoterm_autoinsert = 1
" let g:neoterm_fixedsize = 1
let g:neoterm_autoscroll = '1'
let g:neoterm_default_mod = 'botright'
let g:neoterm_size = 11


let g:opened_neoterm = 0

function! ToggleDropDownNeoterm()
  " If neoterm is open, then save window height before closing
  " so that the next neoterm we open has the same height.
  if g:opened_neoterm

    " neoterm_buff_line is something like: 3 #a \".vimrc\" line 10
    redir => neoterm_buff_line
      silent! execute "filter /neoterm/ ls"
    redir END

    " buff num is first item when u do :ls
    let neoterm_buff_num = split(neoterm_buff_line)[0]

    " get the unique window id from the buffer number
    let neoterm_win_id = win_findbuf(neoterm_buff_num)[0]

    " get window height of open neoterm from it's window id
    let neoterm_win_height = winheight(neoterm_win_id)
    " echom \"neoterm buff num: \" . neoterm_buff_num
    " echom \"the win_id is: \" . neoterm_win_id
    " echom \"it's height: \" . neoterm_win_height

    let g:neoterm_size = neoterm_win_height

    let g:opened_neoterm = 0
    " now close the neoterm window
    Ttoggle

    " commented cuz gave up, currently you get a not-fun error when you open
    " neoterm, switch tabs, then attempt to close it

    " switch to the tab we were in when we saved the layout before restoring
    " it
    " if tabpagenr() != g:tab_when_opened
    "     tabn g:tab_when_opened
    " endif
    " let l:num_tabs = Num_tabs()
    " if l:num_tabs < g:tab_when_opened
    "     echom "Trying to restore layout to a tab which no longer exists"
    " else
    call s:restore_buffer_layout()
    " endif
  else
    let g:opened_neoterm = 1
    " let g:tab_when_opened = tabpagenr()
    call s:save_buffer_layout()
    Ttoggle
  endif
endfunction



command! SaveBufferLayout call s:save_buffer_layout()
command! RestoreBufferLayout call s:restore_buffer_layout()

function s:save_buffer_layout() abort
  let s:buf_layout = winlayout()
  let s:resize_cmd = winrestcmd()
  call s:add_buf_to_layout(s:buf_layout)
endfunction

" add bufnr to leaf
function s:add_buf_to_layout(layout) abort
  if a:layout[0] ==# 'leaf'
    call add(a:layout, winbufnr(a:layout[1]))
  else
    for child_layout in a:layout[1]
      call s:add_buf_to_layout(child_layout)
    endfor
  endif
endfunction

function s:restore_buffer_layout() abort
  if !has_key(s:, 'buf_layout')
    return
  endif

  " create clean window
  new
  wincmd o

  " recursively restore buffers
  call s:apply_layout(s:buf_layout)

  " resize
  exe s:resize_cmd
endfunction

function s:apply_layout(layout) abort

  if a:layout[0] ==# 'leaf'
    if bufexists(a:layout[2])
      exe printf('b %d', a:layout[2])
    endif
  else

    " split cols or rows, split n-1 times
    let split_method = a:layout[0] ==# 'col' ? 'rightbelow split' : 'rightbelow vsplit'
    let wins = [win_getid()]
    for child_layout in a:layout[1][1:]
      exe split_method
      let wins += [win_getid()]
    endfor

    " recursive into child windows
    for index in range(len(wins) )
      call win_gotoid(wins[index])
      call s:apply_layout(a:layout[1][index]) "fzf with custom dictionary
    endfor

  endif
endfunction

" function! Save_window_dimensions()
"     let t:bufs = tabpagebuflist(tabpagenr())
"     let t:buff_heights = []
"     let t:buff_widths = []
"     for buf_num in t:bufs
"         " store the height, width of all buffers
"         call extend(t:buff_heights, winheight(buf_num))
"         call extend(t:buff_widths, winwidth(buf_num))
"     endfor
" endfunction




nnoremap <silent><leader><CR> :call ToggleDropDownNeoterm()<cr>
" nnoremap <silent><leader><CR> :Ttoggle<CR>
vnoremap <silent><leader>ss :TREPLSendSelection<CR>
" this next one defines an operator which I can use to send selections to neoterm
nmap <silent><leader>s <Plug>(neoterm-repl-send)

