" 1st 3 cmd's allow: all runtime files and packages in ~/.vim will be loaded by Neovim.
" Any customisations you make in your ~/.vimrc will now apply to Neovim as
" well as Vim. ---- from http://vimcasts.org/episodes/meet-neovim/
set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath=&runtimepath
source ~/.vimrc
"/home/brendonk/.config/nvim

" Note: need syntax off for treesitter to work !!

lua <<EOF
require'nvim-treesitter.configs'.setup {
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = true,
  },
  indent = {enable = true},
  incremental_selection = {enable = true}
}
EOF
