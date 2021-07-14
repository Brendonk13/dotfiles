
" NOTE: need to change replay mapping, <CR> is for folds
if mapcheck("<Leader>q") == ""
    nmap <unique> <Leader>q <Plug>(Replay)
endif

