

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
