
" show all references with surrounding code in popup, not currently working
nnoremap <silent> gh :Lspsaga lsp_finder<CR>


nnoremap <silent>K :Lspsaga hover_doc<CR>

" allow for scrolling the popup definition
nnoremap <silent> <C-f> <cmd>lua require('lspsaga.action').smart_scroll_with_saga(1)<CR>
nnoremap <silent> <C-b> <cmd>lua require('lspsaga.action').smart_scroll_with_saga(-1)<CR>

" show definition in preview window
nnoremap <silent> gd :Lspsaga preview_definition<CR>

nnoremap <silent> gs :Lspsaga signature_help<CR>

" nnoremap <silent> <A-d> <cmd>lua require('lspsaga.floaterm').open_float_terminal('lazygit')<CR>

" hoowwwww to hook this up to neoterm -- want it to be same terminal each
" time!!
nnoremap <silent> <A-d> :Lspsaga open_floaterm<CR>
tnoremap <silent> <A-d> <C-\><C-n>:Lspsaga close_floaterm<CR>


nnoremap <silent><leader>ca :Lspsaga code_action<CR>
vnoremap <silent><leader>ca :<C-U>Lspsaga range_code_action<CR>
