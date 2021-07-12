
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

