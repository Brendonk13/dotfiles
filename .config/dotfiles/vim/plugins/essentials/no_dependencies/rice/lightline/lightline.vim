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
