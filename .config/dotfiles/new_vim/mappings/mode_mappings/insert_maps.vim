" ======================= MOVEMENT =============================================
" force non-usage of arrow keys
imap <Up>    <Nop>
imap <Down>  <Nop>
imap <Left>  <Nop>
imap <Right> <Nop>

" allow for moving in insert mode
inoremap <C-j> <Down>
inoremap <C-h> <Left>
inoremap <C-l> <Right>
inoremap <C-k> <Up>
" ======================= MOVEMENT =============================================




" ======================= MANIPULATE TEXT ====================================
" frequently want to capitalize a word I just typed
inoremap <C-u> <esc>gUiwea

" frequently find myself knowing I will repeat a word as I type it
" besides, C-c is useless in insert mode
inoremap <C-y> <esc>"iyiwea

" mnemonic: Capitalize
inoremap <C-c> <esc>mtb~`ta
" ======================= MANIPULATE TEXT ====================================




" ======================= ADDED BEHAVIOUR ======================================
" for the rare times you want to stay in insert mode
inoremap <C-e> <C-o>$
inoremap <C-b> <C-o>^

" this inserts a line below me from insert mode
" use '.' since I'm already using this for omni and I want minimal "lag keys"
inoremap ;<CR> <esc>mto<esc>`ta
inoremap ;<BS> <esc>mt<down>0i<BS><esc>`ta
" so now enter, bs operate on lines above me, the dot variant acts on lines below current!
" ======================= ADDED BEHAVIOUR ======================================
