" makes you go down line wise regardless of wrapping.
nnoremap j gj
nnoremap k gk


" <leader><CR> taken up by neoterm
" allow enter key in normal mode use leader key so i don't fuck with quickfix :cw
" nnoremap <leader><CR> a<CR><esc>
" nnoremap <leader><BS> i<BS><esc>
" <CR> would be much better as a function which moved to beginning of word then i<CR>
" iff in cursor in the middle of word



nnoremap ; :
nnoremap ;; ;

" goat mapping -- can now add count to @@
nnoremap Q @@


" ============== INVOLVES REGISTERS ============================================
" makes sense, even suggested in help!
nnoremap Y y$

if has('clipboard')
  nnoremap <silent><leader>y :normal! gv"+y<CR>
  vnoremap <silent><leader>y :normal! gv"+y<CR>
endif
" ============== INVOLVES REGISTERS ============================================



" ============== CASE CHANGING STUFF ===========================================
" I make things upper case so much more than the opposite.
nnoremap gu gU
nnoremap gU gu

nnoremap guu gUU
nnoremap gUU guu

vnoremap gu gU
vnoremap gU gu
" ============== CASE CHANGING STUFF ===========================================



" ============== SEARCH ========================================================
" saner searching
nnoremap g; g;zz
nnoremap g, g,zz
" ============== SEARCH ========================================================




" ============== FIND FILES ====================================================
"http://vimcasts.org/episodes/the-edit-command/
" can automatically expand curr buffer's dir_path with %% anywhere on c-line!!
"  These are hella useful if have mult files in mult dir's open already
cnoremap %% <C-R>=fnameescape(expand('%:p:h')).'/'<cr>
nmap <leader>we :e %%
nmap <leader>se :sp %%
nmap <leader>ve :vs %%
nmap <leader>te :tabe %%
" these^^^ muuuust be map, not noremap!


"nmap / ms/
"nmap ? ms?
" my excuse for not adding these before was that I'd break nerdtree/ some other plugin i'm not using
" and premature optimization is the death of all.. besides <leader>/ is unrememberable
"nnoremap / ms/
"nnoremap ? ms?

" these ^ didn't work, need to change loupe function to do: ms<bar>fxnCall

nnoremap <leader>wf :find<space>
nnoremap <leader>sf :sfind<space>
nnoremap <leader>vf :vert sf<space>
nnoremap <leader>tf :tabfind<space>

" faster spamming of n. , can optionally add a count also!
"nnoremap \ :norm n.<CR>

" now have this mapping for bash && vim
"nnoremap <C-p> :FZF<CR>
" ============-- FIND FILES ====================================================



" ======================= WINDOW MANAGEMENT ====================================


" Allow me to swap the position of any 2 windows
function! MarkWindowSwap()
  let g:markedWinNum = winnr()
endfunction

function! DoWindowSwap()
  "Mark destination
  let curNum = winnr()
  let curBuf = bufnr( "%" )
  exe g:markedWinNum . "wincmd w"
  "Switch to source and shuffle dest->source
  let markedBuf = bufnr( "%" )
  "Hide and open so that we aren't prompted and keep history
  exe 'hide buf' curBuf
  "Switch to dest and shuffle source->dest
  exe curNum . "wincmd w"
  "Hide and open so that we aren't prompted and keep history
  exe 'hide buf' markedBuf 
endfunction

" these functions come from https://stackoverflow.com/questions/2586984/how-can-i-swap-positions-of-two-open-files-in-splits-in-vim/4903681#4903681
nmap <silent> <leader>wm :call MarkWindowSwap()<CR>
nmap <silent> <leader>wp :call DoWindowSwap()<CR>



" maybe I will change this to <C-<lt>> as a normal mode mapping ... this is barely less keystrokes, just nice not to think about numbers
nnoremap <C-w>> <C-w>20>
nnoremap <C-w>2> <C-w>40>
" other direction now
nnoremap <C-w>< <C-w>20<
nnoremap <C-w>2< <C-w>40<


" will use this for my \"drop down\" neoterm
nnoremap <M-j> <C-w>3-
nnoremap <M-k> <C-w>3+

" easier maximization of windows!!
nnoremap <C-w>- <C-w>_
nnoremap <C-w>\ <C-w><bar>

" make current buffer max size
nnoremap <leader>m <C-w>_<C-w><bar>

" easier window switching
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" map :only to <leader>o
nnoremap <silent> <leader>o :only<CR>
" close windows easily!!
nnoremap <silent> <leader>c :close<CR>

" deletes current buffer while preserving layout.
nnoremap <Leader>bd :bp<CR>:bd#<CR>

" ======================= WINDOW MANAGEMENT ====================================



" ======================= BUFFER MANAGEMENT ====================================
" easy switch back to previous buffer
nnoremap <leader><leader> <C-^>

" ------ delete from buffer list ---------
set wildcharm=<C-z>
cnoremap Bd :ls<CR>:      bd<space><C-z>
" have spaces in order to see status ie hidden/active

" ======================= BUFFER MANAGEMENT ====================================

" Open and close folds with Enter
nnoremap <expr> <cr>   foldlevel(line('.'))  ? "za" : "\<cr>"



" ======================= CMD Aliases ==========================================
" <leader>s used by neoterm send as operator
nnoremap <leader>S :source $MYVIMRC<CR>

nnoremap <silent> <C-s> :w<CR>




" deletes all tabs in current file, nice cuz i have listchar set
" mnemonic: Delete tab
nnoremap <leader>d<tab> :%s/\v^\s+$//<CR>


" this >> nerdtree (add netrw_liststyle=3 and behold) --  needs nmap
nmap <leader>ls :vert topleft 22vs %%<CR>
" need to figure out netrw a bit tho ..    -- like how to make close parent dir and make another "root"
