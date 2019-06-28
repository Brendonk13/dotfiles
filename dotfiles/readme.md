# los dotfiles
from https://www.atlassian.com/git/tutorials/dotfiles  
seems all unnecessary now but it works ¯\ _(ツ)_/¯

## Setup
```sh
git init --bare $HOME/.cfg
alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'
config config --local status.showUntrackedFiles no
config remote add origin https://github.com/Brendonk13/dotfiles.git
```

## Replication
```sh
git clone --separate-git-dir=$HOME/.cfg https://github.com/Brendonk13/dotfiles.git dotfiles-tmp
rsync --recursive --verbose --exclude '.git' dotfiles-tmp/ $HOME/
rm --recursive dotfiles-tmp
```

## Configuration
```sh
config status.showUntrackedFiles no
config remote set-url origin https://github.com/Brendonk13/dotfiles.git
```

## Usage
```sh
config status
config add .gitconfig
config commit -m 'Add gitconfig'
config push
```
