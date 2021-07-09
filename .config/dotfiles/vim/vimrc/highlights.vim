
highlight Folded guibg=NONE guifg=LightGray

if has("patch-8.1.1564")
  " Recently vim can merge signcolumn and number column into one
  set signcolumn=number
else
  set signcolumn=yes
endif

highlight SignColumn guibg=bg ctermbg=bg

highlight MatchParen guibg=#006b6b guifg=#D8DEE9

