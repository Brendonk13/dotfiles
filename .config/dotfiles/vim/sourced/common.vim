
"# ============================================================================= #
"# ============================================================================= #
"# ======  plugins/essentials/no_dependencies/rice/pinnacle/pinnacle.vim  ====== #
"# ============================================================================= #


augroup custom_msg_highlights
    autocmd!
    " containedin allows me to have these within comments, contains=@NoSpell
    " means no spell checking for these highlights

    autocmd Syntax * syn match MyTodo /\v<(FIXME|FixMe|fixme|IDEA|Idea|idea|NOTE|Note|note|TODO|Todo|todo|OPTIMIZE|Optimize|optimize):/
          \ containedin=.*Comment,vimCommentTitle contains=@NoSpell
    " FIXME: link fixme to vim's built in highlighting for fixme:

    " URL's
    autocmd Syntax * syn match Link /\v<(link|Link|Links|LINK|LINKS):/
          \ containedin=.*Comment,vimCommentTitle contains=@NoSpell
    autocmd Syntax * syn match URL /\v<(http[s]?:\/\/[^ ]+>)/
          \ containedin=.*Comment,vimCommentTitle contains=@NoSpell

    autocmd Syntax * syn match Memorize /\v:<(mem|Mem|MEM)/
          \ containedin=.*Comment,vimCommentTitle contains=@NoSpell

    autocmd Syntax * syn match Example /\v<(Ex|ex|EX|ie|Ie|IE|i\.e)(:|\.\)).*$/
          \ containedin=.*Comment,vimCommentTitle contains=@NoSpell

    " order: ^(\s*)$<space><letter>(.*)
    autocmd Syntax * syn match Cmd /\v^(\s*)\$ [a-zA-Z](.+)$/
          \ containedin=.*Comment,vimCommentTitle contains=@NoSpell


    " /\v(([^-]-[a-zA-Z0-9]+)|([^-]--[a-zA-Z0-9]+)): 
    " autocmd Syntax * syn match FlagExplanation /\v(\s*)\-(\-?)([a-zA-Z0-9]+): /

    " only match -flag:<space> and --flag:<space> NOT: ---flag or any other # of -'s
    autocmd Syntax * syn match FlagExplanation /\v^\s*([^-](-|--))[a-zA-Z0-9-]+: /
          \ containedin=.*Comment,vimCommentTitle contains=@NoSpell


    " autocmd Syntax * syn match NumberedList /\v(\d+)\. /
    " must be at beginning of line, 1.11.a, 2.a.2 work, 2 ltrs in a row does not
    " can match trailing [: .]
    autocmd Syntax * syn match NumberedList /\v^\s*(\d+\.)(\w|(\d+))?(\.(\w|(\d+)))?([: .] )?/
          \ containedin=.*Comment,vimCommentTitle contains=@NoSpell
    " - FIXME: stop random lines which start with 4.5 from thinking they're in
    "   a numbered list
    "   - solution 1: enforce trailing [: .]
    "   - solution 2: learn how to match stuff in syntax highlights without
    "   highlighting every group


    autocmd Syntax * syn match ListHeader /\v^.+:$(\n\s*)*(0|1)\./
          \ containedin=.*Comment,vimCommentTitle contains=@NoSpell

    " autocmd Syntax * syn match ExampleTwo /\v<(Ex|ex|EX|ie|Ie|IE|i\.e):/
    "       \ containedin=.*Comment,vimCommentTitle
augroup END

" from bottom of: https://stackoverflow.com/questions/4097259/in-vim-how-do-i-highlight-todo-and-fixme

" Colors are chosen from vim-solarized groups for vim files (idk which ones)
highlight LinkColor            cterm=NONE gui=bold ctermfg=4  guifg=#268bd2 ctermbg=NONE guibg=NONE
highlight URL_Color            cterm=NONE gui=NONE ctermfg=13 guifg=#6c71c4 ctermbg=NONE guibg=NONE
highlight MemorizeColor        cterm=NONE gui=NONE ctermfg=13 guifg=#00cd9a ctermbg=NONE guibg=NONE
highlight ExampleColor         cterm=NONE gui=NONE ctermfg=13 guifg=#CCCCCC ctermbg=NONE guibg=NONE
highlight HackColor            cterm=NONE gui=NONE ctermfg=13 guifg=#cc5e22 ctermbg=NONE guibg=NONE

highlight WhiteHeader          cterm=NONE gui=bold ctermfg=13 guifg=#CCCCCC ctermbg=NONE guibg=NONE

highlight CmdColor             cterm=NONE gui=NONE ctermfg=13 guifg=#00ad7a ctermbg=NONE guibg=NONE
highlight FlagExplanationColor cterm=NONE gui=NONE ctermfg=13 guifg=#00a572 ctermbg=NONE guibg=NONE


highlight def link Link         LinkColor
highlight def link URL          URL_Color
highlight def link UrlNoSpell   URL_Color

highlight def link MyTodo       Todo
highlight def link Memorize     MemorizeColor
highlight def link Example      ExampleColor
highlight def link Hack         HackColor

highlight def link Cmd              CmdColor
highlight def link FlagExplanation  FlagExplanationColor

highlight def link ListHeader       WhiteHeader
highlight def link NumberedList     WhiteHeader




hi clear SpellBad
highlight SpellBad guifg=#BA0C2E gui=italic
highlight Search guifg=#F05000 gui=italic,underline
" highlight IncSearch guifg=#BA0C2E gui=italic



"# ============================================================================= #
"# ============================================================================= #
"# =====  plugins/essentials/no_dependencies/rice/lightline/lightline.vim  ===== #
"# ============================================================================= #

" config for lightline, can do hella customization, explained on  https://github.com/itchyny/lightline.vim#solarized-light
" was wombat
let g:lightline = {
   \ 'colorscheme': 'solarized',
   \ 'separator': { 'left': '', 'right': '' },
   \ 'subseparator': { 'left': '', 'right': '' },
   \ 'active' : {
   \   'left': [ [ 'mode', 'paste' ],
   \           [ 'myfilename',  'readonly', 'modified' ] ],
   \   'right': [ [ 'lineinfo' ],
   \            [ 'percent' ],
   \            [ 'filetype' ] ]
   \ },
   \ 'inactive' : {
   \    'right' : [ [ 'modified' ] ]
   \ },
   \ 'component_function': {
   \       'readonly': 'LightlineReadOnly',
   \       'filetype': 'LightlineFileType',
   \       'percent': 'LightlinePercent',
   \       'modified': 'LightlineModified',
   \       'myfilename': 'LightlineFileName',
   \ },
   \ 'component_expand': {
   \       'session' : 'GetObsessionStatus'
   \ },
   \ 'component': {
   \       'lineinfo': '%3l:%-2v' . '←c'
   \ },
   \ 'tabline': {
   \        'left': [ [ 'tabs' ] ],
   \        'right': [ [ 'session' ] ]
   \ }
\ }

" don't care if files are modified in tabs
let g:lightline.tab = {
    \ 'active':   [ 'tabnum', 'filename', 'session' ],
    \ 'inactive': [ 'tabnum', 'filename' ]
\ }
" todo: return '' if ~/.config/dotfiles/vim/plugins/git.vim
" check link: https://vi.stackexchange.com/questions/10939/how-to-see-if-a-plugin-is-active
function! GetObsessionStatus()
    return '%{ObsessionStatus()}'
endfunction

function! LightlineReadOnly()
   return &readonly ? 'RO ' : ''
endfunction

function! LightlineFileName()
    return winwidth(0) < 44 ? expand('%:t:r') : expand('%:t')
endfunction

function! LightlineModified()
    return &modifiable && &modified ? '+' : ''
endfunction

function! LightlinePercent()
    " don't show percent if no space under these conditions
    " because here we have &R.O or '+' taking up space already
    if winwidth(0) < 60
        return ''
    endif

    let file_name = expand('%:t:r')

    " don't show file names if its just a terminal!
    if file_name =~# 'bash'
        return ''
    endif

    let above = line('w0') - 1
    let below = line('$') - line('w$')
    if below <= 0
        return above ? 'Bot' : 'All'
    elseif above <= 0
        return 'Top'
    else
        return printf('%2d%%', above > 1000000 ?
                \ above / ((above + below) / 100) :
                \ above * 100 / (above + below))
    endif
endfunction


" not being used currently
function! LightlineFileType()
   return ''
    " don't show filetype if window < 55
   "return winwidth(0) > 62 ? (&filetype !=# '' ? &filetype : 'no ft') : ''
endfunction


" this deletes the colored line at tabline//below active window

let s:palette = g:lightline#colorscheme#{g:lightline.colorscheme}#palette
let s:palette.tabline.middle = [ [ 'NONE', 'NONE', 'NONE', 'NONE' ] ]


"# ============================================================================= #
"# ============================================================================= #
"# =====  plugins/essentials/no_dependencies/rice/solarized/solarized.vim  ===== #
"# ============================================================================= #

" This is done in the vimrc.vim in root since it changes other highlights if
" done later
" set background=dark
" colorscheme solarized

highlight SignColumn guibg=bg ctermbg=bg

let g:solarized_bold=1
let g:solarized_italic=1


"# ================================================================================ #
"# ================================================================================ #
"#   plugins/essentials/no_dependencies/better_defaults/replay/replay_no_deps.vim   #
"# ================================================================================ #


" NOTE: need to change replay mapping, <CR> is for folds
nmap <unique> <Leader>q <Plug>(Replay)


"# ================================================================================== #
"# ================================================================================== #
"#   plugins/essentials/no_dependencies/better_defaults/vim-abolish/vim-abolish.vim   #
"# ================================================================================== #

if !filereadable(expand("~/.vim/after/plugin/abolish.vim"))
    echoerr 'Loading abolishes FAILED. expected abolishes to be in non-existant file: ~/.vim/after/plugin/abolish.vim'
endif


" Abolishes in that file:

    " Abolish recieve{d,r,s} receive{}
    " Abolish recieving      receiving


"# ======================================================================================== #
"# ======================================================================================== #
"#   plugins/essentials/no_dependencies/better_defaults/vim-commentary/vim-commentary.vim   #
"# ======================================================================================== #

augroup CommentString
  autocmd!
  autocmd Filetype ocaml setlocal commentstring=(*\ %s\ *)
  autocmd Filetype cs setlocal commentstring=//\ %s
  autocmd FileType markdown setlocal commentstring=[//]:\ #\ (%s)
augroup END

