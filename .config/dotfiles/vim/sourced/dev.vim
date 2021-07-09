
"# ============================================================================== #
"# ============================================================================== #
"# ======  plugins/essentials/one_dependency/ocaml/vim-dispatch_ocaml.vim  ====== #
"# ============================================================================== #

autocmd! BufRead,BufNewFile *.ml,*.mli,*.mly,*.mll compiler ocaml


"# ============================================================================== #
"# ============================================================================== #
"# ====  plugins/essentials/one_dependency/latexmk/vim-dispatch_latexmk.vim  ==== #
"# ============================================================================== #


" TODO: turn this into a function which opens pdf in left/right of curr i3
" window.
" autocmd BufDelete *.tex call <SID>deleteLatexGarb()
autocmd! BufWritePost *.tex silent exec "Dispatch! latexmk -pdf -pvc %"

" function! s:deleteLatexGarb()
"     let fil = "Dispatch! latexmk -c l:fil" . "expand('<afile>')"
"     silent execute fil
" endfunction



"# ============================================================================= #
"# ============================================================================= #
"# ===============  plugins/essentials/one_dependency/rg/rg.vim  =============== #
"# ============================================================================= #


" use ripgrep instead of grep
set grepprg=rg



"# ============================================================================= #
"# ============================================================================= #
"# ==========  plugins/essentials/one_dependency/fzf/fzf_no_deps.vim  ========== #
"# ============================================================================= #

" popup windows, stolen from a long ways down this: https://github.com/junegunn/fzf.vim/issues/821

fu s:snr() abort
    return matchstr(expand('<sfile>'), '.*\zs<SNR>\d\+_')
endfu
let s:snr = get(s:, 'snr', s:snr())
let g:fzf_layout = {'window': 'call '..s:snr..'fzf_window(0.92, 0.7, "Comment")'}

fu s:fzf_window(width, height, border_highlight) abort
    let width = float2nr(&columns * a:width)
    let height = float2nr(&lines * a:height)
    let row = float2nr((&lines - height) / 2)
    let col = float2nr((&columns - width) / 2)
    let top = '┌' . repeat('─', width - 2) . '┐'
    let mid = '│' . repeat(' ', width - 2) . '│'
    let bot = '└' . repeat('─', width - 2) . '┘'
    let border = [top] + repeat([mid], height - 2) + [bot]
    if has('nvim')
        let frame = s:create_float(a:border_highlight, {
            \ 'row': row,
            \ 'col': col,
            \ 'width': width,
            \ 'height': height,
            \ })
        call nvim_buf_set_lines(frame, 0, -1, v:true, border)
        call s:create_float('Normal', {
            \ 'row': row + 1,
            \ 'col': col + 2,
            \ 'width': width - 4,
            \ 'height': height - 2,
            \ })
        exe 'au BufWipeout <buffer> bw '..frame
    else
        let frame = s:create_popup_window(a:border_highlight, {
            \ 'line': row,
            \ 'col': col,
            \ 'width': width,
            \ 'height': height,
            \ 'is_frame': 1,
            \ })
        call setbufline(frame, 1, border)
        call s:create_popup_window('Normal', {
            \ 'line': row + 1,
            \ 'col': col + 2,
            \ 'width': width - 4,
            \ 'height': height - 2,
            \ })
    endif
endfu

fu s:create_float(hl, opts) abort
    let buf = nvim_create_buf(v:false, v:true)
    let opts = extend({'relative': 'editor', 'style': 'minimal'}, a:opts)
    let win = nvim_open_win(buf, v:true, opts)
    call setwinvar(win, '&winhighlight', 'NormalFloat:'..a:hl)
    return buf
endfu

fu s:create_popup_window(hl, opts) abort
    if has_key(a:opts, 'is_frame')
        let id = popup_create('', #{
            \ line: a:opts.line,
            \ col: a:opts.col,
            \ minwidth: a:opts.width,
            \ minheight: a:opts.height,
            \ zindex: 50,
            \ })
        call setwinvar(id, '&wincolor', a:hl)
        exe 'au BufWipeout * ++once call popup_close('..id..')'
        return winbufnr(id)
    else
        let buf = term_start(&shell, #{hidden: 1})
        call popup_create(buf, #{
            \ line: a:opts.line,
            \ col: a:opts.col,
            \ minwidth: a:opts.width,
            \ minheight: a:opts.height,
            \ zindex: 51,
            \ })
        exe 'au BufWipeout * ++once bw! '..buf
    endif
endfu

command! -bang -nargs=? -complete=dir Files
    \ call fzf#vim#files(<q-args>, fzf#vim#with_preview({'options': ['--layout=reverse', '--info=inline']}), <bang>0)


" Note: fzf depeneds on having ripgrep installed
let g:fzf_action = {
   \ 'ctrl-t': 'tab split',
   \ 'ctrl-s': 'split',
   \ 'ctrl-v': 'vsplit' }


" don't think I need these
" " nnoremap <silent> <M-f> :FzfPreviewProjectFiles<CR>
" let g:fzf_preview_use_dev_icons = 1
" let g:fzf_preview_lines_command = 'bat --color=always --style=grid --theme=ansi-dark --plain'
" let g:fzf_binary_preview_command = 'echo "{} is a binary file"'
" " let g:fzf_preview_filelist_postprocess_command = 'xargs -d "\n" ls -U --color'
" let g:fzf_preview_filelist_postprocess_command = 'xargs -d "\n" exa --color=always'
" let g:fzf_preview_floating_window_winblend = 4
" " let g:fzf_preview_grep_cmd = 'rg --line-number --no-heading --smart-case --files --hidden --iglob "!.DS_Store" --iglob "!.git"'
" " let g:fzf_preview_directory_files_command = 'rg --files --hidden --column --line-number --no-heading  --smart-case --color=always'
" " let g:fzf_preview_fzf_color_option = ' --colors "path:fg:190,220,255" --colors "line:fg:128,128,128"'
" " let g:fzf_preview_grep_cmd = 'rg --line-number --no-heading --color=always --colors "path:fg:190,220,255" --colors "line:fg:128,128,128" --smart-case'

" Better search history
command! QHist call fzf#vim#search_history({'bottom': '10'})


" Better command history
command! CmdHist call fzf#vim#command_history({'bottom': '10'})


" Better command history with q:
nnoremap q: :CmdHist<CR>

" Better search history
nnoremap q/ :QHist<CR>


nnoremap <silent> <M-b> :Buffers<CR>

nnoremap <silent> <M-f> :Files %:p:h<CR>

"mnemonic: meta-current
nnoremap <M-c> :BLines<CR>

" mnemonic: meta-help
nnoremap <M-h> :Helptags<CR>


"# ============================================================================== #
"# ============================================================================== #
"# ======  plugins/essentials/one_dependency/javac/vim-dispatch_javac.vim  ====== #
"# ============================================================================== #


autocmd! Filetype java setlocal makeprg=javac\ %
autocmd! Filetype java setlocal errorformat=%A%f:%l:\ %m,%-Z%p^,%-C%.%#


"# ============================================================================= #
"# ============================================================================= #
"# =======  plugins/essentials/one_dependency/git/fugitive/fugitive.vim  ======= #
"# ============================================================================= #

augroup Git
  autocmd!
  " delete fugitive buffers to avoid clogging buffer list.
  autocmd BufReadPost fugitive://* set bufhidden=delete
augroup END



"# ============================================================================= #
"# ============================================================================= #
"# ==========  plugins/essentials/few_dependencies/fzf_rg/fzf_rg.vim  ========== #
"# ============================================================================= #


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



"# ============================================================================= #
"# ============================================================================= #
"# ======  plugins/essentials/few_dependencies/fzf_git_rg/fzf_rg_git.vim  ====== #
"# ============================================================================= #

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

