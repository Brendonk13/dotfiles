
command! -bang -nargs=* RgCurrentBufferDir
    \ cd %:p:h |
    \ call fzf#vim#grep(
    \   'rg --column --line-number --no-heading --color=always --colors "path:fg:190,220,255" --colors "line:fg:128,128,128" --smart-case '.shellescape(<q-args>), 1,
    \   fzf#vim#with_preview({'dir': expand('%:p:h')}), <bang>0)



" This function allows me to pass in the same parameters on the command line!!!
function! RipgrepFzf(query, fullscreen)
  let command_fmt = 'rg --column --line-number --no-heading --color=always --colors "path:fg:190,220,255" --colors "line:fg:128,128,128" --smart-case -- %s || true'
  let initial_command = printf(command_fmt, shellescape(a:query))
  let reload_command = printf(command_fmt, '{q}')
  let spec = {'options': ['--phony', '--query', a:query, '--bind', 'change:reload:'.reload_command]}
  call fzf#vim#grep(initial_command, 1, fzf#vim#with_preview(spec), a:fullscreen)
endfunction

" This command allows me to pass in the same parameters on the command line!!!
command! -nargs=* -bang RG call RipgrepFzf(<q-args>, <bang>0)
nnoremap <silent> <M-r> :cd %:p:h<CR><bar>:RG<CR>



function! FuzzySearchPattern(inp)
    " inp is text like: '(E)xamples, (N)otes
    let chosen_letter = a:inp[1]
    let parsed = a:inp[3:]
    let user_input = chosen_letter . parsed

    let search_cmd = {
            \ 'Examples': '\b(Ex|ex|EX|ie|Ie|IE|i\.e)(:|\.\)).*$',
            \ 'Hacks': ':(hack|Hack|HACK)',
            \ 'Mems':  '\b:(mem|Mem|MEM)',
            \ 'Notes': '\b(NOTE|Note|note):',
            \ 'Urls':  '\b(http[s]?://[^ ]+\b)',
        \ }
    " for name in keys(search_cmd)
    "     echom name
    "     command! name call RipgrepFzf(search_cmd[name], 0)
    " endfor

    let pattern = search_cmd[user_input]
    " echom pattern
    call RipgrepFzf(pattern, 0)
endfunction



function! SearchCustomMarks()
    cd %:p:h
    let pickLetter = [
            \ '(E)xamples',
            \ '(H)acks',
            \ '(M)ems',
            \ '(N)otes',
            \ '(U)rls',
        \ ]
    call fzf#run(fzf#wrap({'source': pickLetter, 'sink': function('FuzzySearchPattern')}))
endfunction

command! Cust call SearchCustomMarks()



" Global line completion (not just open buffers. ripgrep required.)
inoremap <expr> <c-x><c-l> fzf#vim#complete(fzf#wrap({
    \ 'prefix': '^.*$',
    \ 'source': 'rg -n ^ --color always',
    \ 'options': '--ansi --delimiter : --nth 3..',
    \ 'reducer': { lines -> join(split(lines[0], ':\zs')[2:], '') }}))

