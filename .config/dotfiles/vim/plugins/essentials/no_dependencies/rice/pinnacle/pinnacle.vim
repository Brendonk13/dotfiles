
augroup custom_msg_highlights
    autocmd!
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

