
"# ============================================================================== #
"# ============================================================================== #
"# ====================  plugins/others/neoterm/neoterm.vim  ==================== #
"# ============================================================================== #



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



"# ============================================================================== #
"# ============================================================================== #
"# ==========  plugins/others/better_vis_mode/vim-vmath/vim-vmath.vim  ========== #
"# ============================================================================== #


" from damian conway's vim talk
vnoremap <expr> ++ VMATH_YankAndAnalyse()
nnoremap ++  vip++



"# ============================================================================== #
"# ============================================================================== #
"# ==================  plugins/others/ultisnips/ultisnips.vim  ================== #
"# ============================================================================== #


" call setup files in dirs in this dir


" let g:UltiSnipsExpandTrigger='<C-Space>'

let g:UltiSnipsExpandTrigger="<S-tab>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"

" let g:UltiSnipsSnippetsDir="~/new_dotfiles/vim/plugins/pc/ultisnips/my_snips"
let g:UltiSnipsSnippetDirectories = [ '~/.config/vim/plugins/others/ultisnips/my_snips']


" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="vertical"



"# ============================================================================== #
"# ============================================================================== #
"# ===============  plugins/others/prose/limelight/limelight.vim  =============== #
"# ============================================================================== #

let g:limelight_default_coefficient = 0.3


"# ============================================================================== #
"# ============================================================================== #
"# ====================  plugins/others/prose/goyo/goyo.vim  ==================== #
"# ============================================================================== #


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



"# ============================================================================== #
"# ============================================================================== #
"# =============  plugins/others/vim-easy-align/vim-easy-align.vim  ============= #
"# ============================================================================== #

" NOTE: much easier to just align using regex than adding a delimeter.
" EasyAlign /->/

let g:easy_align_delimiters = {
  \ ';': { 'pattern': ';', 'left_margin': 0, 'stick_to_left': 1 } }


xmap <leader>ga <Plug>(EasyAlign)

" this allows for easy alignment based on searching
xmap ga :EasyAlign //<left>

" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

" nmap <leader>ga :EasyAlign



"# ============================================================================== #
"# ============================================================================== #
"# ========================  plugins/others/coc/coc.vim  ======================== #
"# ============================================================================== #


function! SetupCommandAbbrs(from, to)
  exec 'cnoreabbrev <expr> '.a:from
        \ .' ((getcmdtype() ==# ":" && getcmdline() ==# "'.a:from.'")'
        \ .'? ("'.a:to.'") : ("'.a:from.'"))'
endfunction

" Use C to open coc config
call SetupCommandAbbrs('C', 'CocConfig')


inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction


" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif


if exists('*complete_info')
  inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
else
  inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
endif

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)


" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current buffer.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" Use CTRL-S for selections ranges.
" Requires 'textDocument/selectionRange' support of LS, ex: coc-tsserver
nmap <silent> S 0<Plug>(coc-range-select)
xmap <silent> S 0<Plug>(coc-range-select)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
" set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Mappings for CoCList
" Show all diagnostics.
nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions.
nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<cr>
" Show commands.
nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document.
nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols.
nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list.
nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>


function! MyFoldText()
    let line = getline(v:foldstart)
    let folded_line_num = v:foldend - v:foldstart
    let line_text = substitute(line, '^"{\+', '', 'g')
    let fillcharcount = &textwidth - len(line_text) - len(folded_line_num)
    return '++  '. repeat('-', 2) . '  ' . line_text . '  ' . repeat('-', fillcharcount) . '  (' . folded_line_num . ' L)  '
endfunction


" hi Folded ctermfg=White guibg=None
set foldtext=MyFoldText()


"# ============================================================================== #
"# ============================================================================== #
"# ================  plugins/others/quick-scope/quick-scope.vim  ================ #
"# ============================================================================== #


" doesn't work for terminal anyways
let g:qs_buftype_blacklist = ['terminal']

" don't quick_scope for long lines
let g:qs_max_chars=100
let g:qs_highlight_on_keys = ['f', 'F', 't', 'T']

augroup qs_colors
  autocmd!
  autocmd ColorScheme * highlight QuickScopePrimary guifg='#afff5f' gui=underline ctermfg=155 cterm=underline
  autocmd ColorScheme * highlight QuickScopeSecondary guifg='#5fffff' gui=underline ctermfg=81 cterm=underline
augroup END


"# ============================================================================== #
"# ============================================================================== #
"# =====================  plugins/others/vimtex/vimtex.vim  ===================== #
"# ============================================================================== #


" needed to specify if .tex file is: TeX, ConTeXt, or LaTeX
let g:tex_flavor = 'latex'


" needed to have vimtex automatically go to certain lines in pdf (forward searching)
if empty(v:servername) && exists('*remote_startserver')
    call remote_startserver('VIM')
endif
let g:vimtex_quickfix_open_on_warning = 0

" I usually just copy pasta citations so don't care if they are missing fields
let g:vimtex_quickfix_ignore_filters = [
    \ 'Missing "author"',
\]

augroup Latex
    autocmd!
    " TODO: turn this into a function which opens pdf in left/right of curr i3
    " window.
    autocmd BufRead,BufNewFile *.tex compiler chktex
    " autocmd BufWrite <buffer=abuf> compiler bibertool | lmake!

    " this line was commented in og vimrc
    autocmd BufWrite *.tex Make
    " autocmd BufWritePost *.tex silent exec "Dispatch! latexmk -pdf -pvc %"
augroup END

let g:vimtex_compiler_method = 'latexmk'
let g:latex_view_general_viewer = "zathura"
let g:vimtex_view_method = "zathura"
" The quickfix window is opened automatically when there are errors,
" but it does not become the active window.
let g:vimtex_quickfix_mode = 2

if has('nvr') " use this ??
let g:vimtex_compiler_progname = 'nvr'
endif


let g:vimtex_view_forward_search_on_start = 0


" =========== conceal stuff like $...$ =========================
" One of the neosnippet plugins will conceal symbols in LaTeX which is confusing
let g:tex_conceal = ""
set conceallevel=1
let g:tex_conceal='abdmg'
" =========== conceal stuff like $...$ =========================

let g:tex_comment_nospell = 1

" Steal ideas:
" feature to highlight where a line is in pdf (shown @@ 2:50 https://www.youtube.com/watch?v=KGqrpnxoDxw)


" from: https://gist.github.com/skulumani/7ea00478c63193a832a6d3f2e661a536
" " Can hide specifc warning messages from the quickfix window
" " Quickfix with Neovim is broken or something
" " https://github.com/lervag/vimtex/issues/773
" let g:vimtex_quickfix_latexlog = {
"           \ 'default' : 1,
"           \ 'fix_paths' : 0,
"           \ 'general' : 1,
"           \ 'references' : 1,
"           \ 'overfull' : 1,
"           \ 'underfull' : 1,
"           \ 'font' : 1,
"           \ 'packages' : {
"           \   'default' : 1,
"           \   'natbib' : 1,
"           \   'biblatex' : 1,
"           \   'babel' : 1,
"           \   'hyperref' : 1,
"           \   'scrreprt' : 1,
"           \   'fixltx2e' : 1,
"           \   'titlesec' : 1,
"           \ },
"           \}


"# ============================================================================== #
"# ============================================================================== #
"# ==================  plugins/others/git/signify/signify.vim  ================== #
"# ============================================================================== #

set updatetime=256

