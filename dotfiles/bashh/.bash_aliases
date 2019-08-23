#alias doc='cd /mnt/c/Users/Brendon*/Documents/Documents/'
#alias sem='doc;  cd 00*/0*/0*/'
#alias dow='cd /mnt/c/Users/Brendon*/Downloads/'
#alias song='dow;  cd W*/Av*/'

#alias do

alias cd..='cd ..'
alias   .='ls'
alias  ..='cd ..;  ls'
alias ...='up 2;  ls'

alias rpy='python3'

alias newc='conda create -n'
alias remc='conda env remove --name'   
alias act='conda activate'
alias deac='conda deactivate'

# maybe I want to add in --hidden, .. later
alias ag='ag --path-to-ignore ~/.ignore'

alias vi='nvim'
alias v='nvim'

#alias s!='sudo "!!"'

# mnemonic: add sudo
alias as='sudo $(history -p !!)'


# note that can make sudo work with aliases by adding: 
# alias sudo='sudo ' -- the trailing space tells shell to look for aliases in other that first word of cmd

# need to actually add files to bare dotfile repo
# just add and commit files one at a time ie config add .vimr, config com.. config push finally

alias pip='pip3'
alias vim='nvim'
# this is a function defined in .betterBash
alias cdl=changeDirAndShow
alias cdl..='cdl ..'
#alias lcc..='lcc ..'
# -A doesn't show ., .. directories while -a does
alias lsa='ls -A'
alias ll='ls -l'
alias dotf='cd ~/dotfiles/bashh; lsa'
alias ag='ag --ignore-dir ~/FromInternet'
alias gcom='git commit -m'

