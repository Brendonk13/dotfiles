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
