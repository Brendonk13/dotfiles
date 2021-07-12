
# ============================================================================ #
# ============================================================================ #
# ====================  vimrc/setup_undo_backups_etc.vim  ==================== #
# ============================================================================ #


" ============ SETUP UNDO ==========================================
if has('persistent_undo')
    if exists('$SUDO_USER')
        set noundofile
    else
        if !isdirectory(expand('$HOME/.vim/tmp/undo'))
            silent !mkdir -p $HOME/.vim/tmp/undo
            echoerr 'Created directory: $HOME/.vim/tmp/undo since it did not exist'
        endif
        set undodir=~/.vim/tmp/undo
        " actually turn on undofiles
        set undofile
    endif
endif

" ============ SETUP BACKUPS ===========================================
" root user created backups mean that non root's can no longer access backups
if exists('$SUDO_USER')
    set nobackup
    set nowritebackup
else
    if !isdirectory(expand('$HOME/.vim/tmp/backup'))
        silent !mkdir -p $HOME/.vim/tmp/backup
        echoerr 'Created directory: $HOME/.vim/tmp/backup since it did not exist'
    endif
    set backupdir=$HOME/.vim/tmp/backup
    " if first option doesn't exist, write to current directory
endif

" note i can eliminate swap files from my life with wincent/terminus
" or the plugin made by damian conway listed in potential plugin file
" don't allow root to create swap files to avoid similar headaches
" ------------ SETUP SWAPFILE ------------------------------------------
if exists('$SUDO_USER')
    set noswapfile
else
    set directory=$HOME/.vim/tmp/backup//
    set directory+=~/local/.vim/tmp/backup//
    set directory+=.
    " if first option doesn't exist, write to current directory
endif


# ============================================================================ #
# ============================================================================ #
# ==========================  vimrc/highlights.vim  ========================== #
# ============================================================================ #


highlight Folded guibg=NONE guifg=LightGray

highlight MatchParen guibg=#006b6b guifg=#D8DEE9



# ============================================================================ #
# ============================================================================ #
# ===========================  vimrc/settings.vim  =========================== #
# ============================================================================ #

set nocompatible

" ================= QOL improvements =========================================
set wildignore=*.o,*.a,*.so,*.pyc,*.swp,.git/*,*.class,*.dll,~/.vim_black/,~/.vim_black/**~/.vim_black,*pycache*,*.cmi,*.cmo,*.cmx,*.mli,*.depends,*.native,_build/*
set wildignorecase
set wildmode=longest:full

"default for nvim, but who knows about elsewhere..
set encoding=utf-8
set autoread              " re-read file into buffer if disk version changed while vim's open

set shortmess+=c

" disables redrawing screen while executing macros -- faster macro execution
set lazyredraw

" for security reasons
set nomodeline

" allow :bn instead of :bn! for swapping a hidden buffer to buffer list
set hidden

" I. will. not. capitalize.
set spellcapcheck=

" only show top 5 suggestions, never going to look through more options
set spellsuggest=fast,5

if exists('&belloff')
" bells bad!
  set belloff=all
endif

" ================= Aesthetics =========================================
set laststatus=2

set formatoptions+=n
" highlight current line
set cursorline
" " don't wrap line mid-word
if has('linebreak')
    set linebreak
  let &showbreak='  ⤷ '                 " ARROW POINTING DOWNWARDS THEN CURVING RIGHTWARDS (U+2937, UTF-8: E2 A4 B7)
endif


" cursor now only goes within 1 line of top/bottom
set scrolloff=1

" wow this is great, lines wrap at same indentation as previous line
set breakindent

if has('virtualedit')
    "idk how to explain, nice for visual block mode
    set virtualedit=block
endif


set list
set listchars=trail:•
set listchars+=tab:▷┅
"U25B7 then U2505

set matchtime=3

" tree view!
let g:netrw_liststyle=3

" now the insert shit doesnt show at bottom, have vim lightline now!
set noshowmode


" ================================================================================================
" this allows for usage of truecolor !
set termguicolors
set t_Co=256
" NOTE: will have to do some checks here to see if the terminal supports 256
" colors !!!!
" Fix using different colorscheme in terminal mode (was hard to read the old colors)
" use terminal's colorscheme in terminal mode: https://github.com/neovim/neovim/issues/2897
let g:terminal_color_0 = '#000000'
let g:terminal_color_8 = '#545454'
let g:terminal_color_1 = '#ff0000'
let g:terminal_color_9 = '#f40d17'
let g:terminal_color_2 = '#37dd21'
let g:terminal_color_10 = '#3bcf1d'
let g:terminal_color_3 = '#fee409'
let g:terminal_color_11 = '#ecc809'
let g:terminal_color_4 = '#1460d2'
let g:terminal_color_12 = '#5555ff'
let g:terminal_color_5 = '#ff005d'
let g:terminal_color_13 = '#ff55ff'
let g:terminal_color_6 = '#00bbbb'
let g:terminal_color_14 = '#6ae3f9'
let g:terminal_color_7 = '#bbbbbb'
let g:terminal_color_15 = '#ffffff'
" ================================================================================================





" syntax enable
syntax on
set background=dark
colorscheme solarized

" sets vertical split to be a bar
set fillchars+=vert:│
highlight VertSplit ctermbg=NONE guibg=NONE

if has("patch-8.1.1564")
  " Recently vim can merge signcolumn and number column into one
  set signcolumn=number
else
  set signcolumn=yes
endif

highlight SignColumn guibg=bg
highlight SignColumn ctermbg=bg

set fillchars+=stlnc:~
highlight StatusLineNC ctermbg=NONE guibg=NONE


" Don't show URL's as incorrectly spelled
syn match UrlNoSpell "\w\+:\/\/[^[:space:]]\+" contains=@NoSpell

" these settings don't autocomplete my omni-complete till i press enter!
" yes enter, i have a mapping to use this instead of <C-y>
set completeopt=longest,menuone,preview
highlight Pmenu ctermbg=238 gui=bold
" This color is similar to my background color, I like it better


" ================= usability ================================================
set switchbuf=usetab

set mouse=a
set mousemodel=popup

" the splits feel more natural this way 
set splitright
set splitbelow

set autoindent
" This doesn't seem to add anything strangely ..
set backspace=indent,eol,start
" tabs take up 4 spaces
set tabstop=4
" now, pressing tab key inserts spaces automatically
set expandtab
" shift width is how much a line is shifted by when >> is pressed (in normal mode)
set shiftwidth=4
" deletes expanded tab in 1 backspace
set softtabstop=4
" round up tabs to always be multiple of 4
set shiftround

" case insensitive search by default
set ignorecase
" override ignorecase if capital entered mid search
set smartcase
" jump to candidates while typing search pattern
set incsearch
" assume the /g flag on :s substitutions to replace all matches in a line
set gdefault


let g:python3_host_prog='/usr/bin/python'



if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif



# ============================================================================ #
# ============================================================================ #
# ==========================  autocmds/minimal.vim  ========================== #
# ============================================================================ #


augroup ShiftWidth
  autocmd!
  autocmd Filetype xml,yaml,html setlocal shiftwidth=2 tabstop=2 softtabstop=2
  autocmd Filetype make setlocal shiftwidth=2 tabstop=2 softtabstop=2 expandtab
augroup END


augroup NoLists
  autocmd!
  " have seen a disorienting ammount of tabs in project
  autocmd Filetype java setlocal nolist
augroup END


augroup Spelling
    autocmd!
    " format a line, add this to autocmds for text files
    " nnoremap =al mt^~I- <esc>`t
    autocmd BufRead,BufNewFile *.md,*.rst,*.txt,*.tex setlocal spell spelllang=en_us
    autocmd FileType gitcommit setlocal spell spelllang=en_us
    " no spellcheck in help files
    autocmd FileType help setlocal nospell
    " Don't show URL's as incorrectly spelled
augroup END


augroup Leftovers
  autocmd!
  autocmd FileType netrw setlocal bufhidden=wipe
  autocmd BufRead,BufNewFile *.md,*.rst,*.txt,*.tex syn match UrlNoSpell "\w\+:\/\/[^[:space:]]\+" contains=@NoSpell
augroup END


augroup Marks
  autocmd!
  " autocmd BufLeave *.css,*.less,*scss normal! mC
  " C# files
  autocmd BufLeave *.cs               normal! mC
  " autocmd BufLeave *.html             normal! mH
  autocmd BufLeave *.java             normal! mJ
  autocmd BufLeave *.py               normal! mP
  " autocmd BufLeave vimrc,*.vim      normal! mV
  " Ocaml, lexers, parsers
  autocmd BufLeave *.ml,*.mll,*.mly   normal! mO
augroup END

" note that i won't need these after i just change the names to .vim
augroup vimFiles
  autocmd!
  autocmd Bufread */vimm/* setlocal shiftwidth=2 tabstop=2 softtabstop=2 ft=vim
  autocmd Bufread ~/dotfiles/.vim_mappings setlocal shiftwidth=2 tabstop=2 softtabstop=2 ft=vim
augroup END



# ============================================================================ #
# ============================================================================ #
# ==========================  autocmds/desktop.vim  ========================== #
# ============================================================================ #



augroup BackgroundHighlight
    autocmd!
    autocmd! WinEnter * setlocal colorcolumn=0 cursorline
    autocmd! WinLeave * setlocal nocursorline colorcolumn=1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51,52,53,54,55,56,57,58,59,60,61,62,63,64,65,66,67,68,69,70,71,72,73,74,75,76,77,78,79,80,81,82,83,84,85,86,87,88,89,90,91,92,93,94,95,96,97,98,99,100,101,102,103,104,105,106,107,108,109,110,111,112,113,114,115,116,117,118,119,120,121,122,123,124,125,126,127,128,129,130,131,132,133,134,135,136,137,138,139,140,141,142,143,144,145,146,147,148,149,150,151,152,153,154,155,156,157,158,159,160,161,162,163,164,165,166,167,168,169,170,171,172,173,174,175,176,177,178,179,180,181,182,183,184,185,186,187,188,189,190,191,192,193,194,195,196,197,198,199,200,201,202,203,204,205,206,207,208,209,210,211,212,213,214,215,216,217,218,219,220,221,222,223,224,225,226,227,228,229,230,231,232,233,234,235,236,237,238,239,240
    " guibg=#111212 ish -- kinda black
    autocmd WinLeave * highlight ColorColumn guibg=#000211 ctermbg=gray ctermfg=gray
augroup END




" for some reason my hacky colorcolumn does not work with functions.
"function! ColorColsTill(n)
"  silent! setlocal nocursorline
"  let count=1
"  while count<=a:n
"    silent! set cc += count
"    "set cc+=count
"    let count+=1
"  endwhile
"endfunction

"function Turn


"1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51,52,53,54,55,56,57,58,59,60,61,62,63,64,65,66,67,68,69,70,71,72,73,74,75,76,77,78,79,80,81,82,83,84,85,86,87,88,89,90,91,92,93,94,95,96,97,98,99,100,101,102,103,104,105,106,107,108,109,110,111,112,113,114,115,116,117,118,119,120,121,122,123,124,125,126,127,128,129,130,131,132,133,134,135,136,137,138,139,140,141,142,143,144,145,146,147,148,149,150,151,152,153,154,155,156,157,158,159,160,161,162,163,164,165,166,167,168,169,170,171,172,173,174,175,176,177,178,179,180,181,182,183,184,185,186,187,188,189,190,191,192,193,194,195,196,197,198,199,200,201,202,203,204,205,206,207,208,209,210,211,212,213,214,215,216,217,218,219,220,221,222,223,224,225,226,227,228,229,230,231,232,233,234,235,236,237,238,239,240,241,242,243,244,245,246,247,248,249,250,251,252,253,254


# ============================================================================= #
# ============================================================================= #
# ==========================  mappings/mappings.vim  ========================== #
# ============================================================================= #

let mapleader = " "
let maplocalleader = " "

"           note that <CR> by itself is not used in normal mode!!!
"-- here do: map <expr> <CR> empty(&buftype) ? '@@' : '<CR>'
" so that <CR> works on special buffers like qf window!!
" --- use the replay plugin if ever map <CR> @@

"another dece one is <S-Tab>
" also d<CR> and most char<CR> combos are free space!!
" look into the usefulness of current K command!
" currently never use U, and replace mode is replacable
" the Z cmd not used, but theres a delay when mapping cuz of ZZ cmd
" would be sickkk if i could get rid of that delay (kinda)




" need to map something to save a file and then swithc down buffers to a
" terminal and enter it as well
"nnoremap 


" http://learnvimscriptthehardway.stevelosh.com/chapters/15.html\   has nice operator pending maps 
" https://medium.com/@sidneyliebrand/a-collection-of-vim-key-binds-4d227c9a455


" would be nice to have a drop down general use terminal for traversing purposes
" was thinking it would be nice to have one per tab
"nnoremap <silent>,<CR> :call ()<cr>


# ============================================================================ #
# ============================================================================ #
# =================  mappings/mode_mappings/insert_maps.vim  ================= #
# ============================================================================ #

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


# ============================================================================ #
# ============================================================================ #
# ==============  mappings/mode_mappings/terminal_mappings.vim  ============== #
# ============================================================================ #


" if has('nvim')
if exists(':terminal')

  " so for some reason these alt mappings don't work consistently
  " but working so far for escaping terminal mode, can delete others probly
  tnoremap <M-[> <C-\><C-n>
  " using meta key allows for the esc key to work in terminal mode still

  " Terminal mode:
  tnoremap <M-h> <c-\><c-n><c-w>h
  tnoremap <M-j> <c-\><c-n><c-w>j
  tnoremap <M-k> <c-\><c-n><c-w>k
  tnoremap <M-l> <c-\><c-n><c-w>l

  " currently don't even use nu, rnu but may as well keep.
  augroup term
  autocmd!
  autocmd TermOpen * setlocal nonumber norelativenumber
  augroup END

  "should probly change these to <leader>__t to be consistent with my other normal mode splits
  nnoremap <silent> <leader>wt :terminal<CR>i
  nnoremap <silent> <leader>vt :vs<bar>:terminal<CR>i
  nnoremap <silent> <leader>st :sp<bar>:terminal<CR>i
  nnoremap <silent> <leader>tt :tabnew<bar>:terminal<CR>i

    " this sets a red cursor for terminal mode!
    highlight TermCursor ctermfg=red guifg=red

endif


# ============================================================================ #
# ============================================================================ #
# =================  mappings/mode_mappings/normal_maps.vim  ================= #
# ============================================================================ #

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


# ============================================================================ #
# ============================================================================ #
# =================  mappings/mode_mappings/visual_maps.vim  ================= #
# ============================================================================ #


" this visually selects most recent paste/insert mode session
nnoremap gV `[v`]

" allow '.' and '@' to work in VISUAL MODE
" note these don't work with recursive macros, v tempted to get wincent's
" plugin which reassigns <CR> to @@ but runs most recently created OR recently used AND works with recursive macros
vnoremap . :norm .<CR>
vnoremap Q :norm @@<CR>
" added this plugin just now in new dotfiles


" keep selection after shifting
vnoremap < <gv
vnoremap > >gv

" move down a line regardless of wrapping
vnoremap j gj
vnoremap k gk



# ============================================================================= #
# ============================================================================= #
# ==============  mappings/related_mappings/random_mappings.vim  ============== #
# ============================================================================= #


" ============== MARKS =========================================================
" the backticks are way more useful marks than quotes
onoremap ' `
onoremap ` '


" backtick is a way better mark
nnoremap ' `
nnoremap ` '
" ============== MARKS =========================================================



# ============================================================================ #
# ============================================================================ #
# ===============  mappings/related_mappings/omnicomplete.vim  =============== #
# ============================================================================ #



" no omnicomplete mappings if I have coc plugin running
if exists(':CocStart')
    finish
endif

inoremap <silent> ;; <C-x><C-o>

" all of these omnicomplete mappings are from https://vim.fandom.com/wiki/Make_Vim_completion_popup_menu_work_just_like_in_an_IDE
inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

"note that above started with :inoremap

inoremap <expr> <C-n> pumvisible() ? '<C-n>' :
\ '<C-n><C-r>=pumvisible() ? "\<lt>Down>" : ""<CR>'

" if I want preview window to stay open after
" then change to InsertLeave
augroup omniComplete
    autocmd!
    autocmd CompleteDone * pclose
augroup END

"I need a autocmd that does <C-n><C-p> every time I press a letter? so that I can view a preview always
" what might be better tho is so just have a key mapped to <C-n><C-p> ... or maybe just press those keystrokes when this is desired behavior


# ============================================================================= #
# ============================================================================= #
# ==================  other/abbreviations/abbreviations.vim  ================== #
# ============================================================================= #


inoreabbrev slef self

cnoreabbrev makrs marks




# ============================================================================= #
# ============================================================================= #
# =======  os_specific/windows/desktop/clip.exe/copy_sys_clipboard.vim  ======= #
# ============================================================================= #


"from: https://stackoverflow.com/questions/44480829/how-to-copy-to-clipboard-in-vim-of-bash-on-windows
" just calls the native windows clip.exe function nice n simple
func! GetSelectedText()
  normal! gv"ty
  let result = getreg("t")
  return result
endfunc

"this is used by WSL
if executable("clip.exe")
  echom "clip.exe is executable"
  noremap <silent><leader>y :call system('clip.exe', GetSelectedText())<CR>
  " could/should add a cut command but who cares
  "noremap <C-X> :call system('clip.exe', GetSelectedText())<CR>gvx
endif

