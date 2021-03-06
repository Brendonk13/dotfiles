# my dotfile setup
Idea for using bare repo from https://www.atlassian.com/git/tutorials/dotfiles

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
alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'
config config --local status.showUntrackedFiles no
```

## Replication one-liner
```
git clone --separate-git-dir=$HOME/.cfg https://github.com/Brendonk13/dotfiles.git dotfiles-tmp && rsync --recursive --verbose --exclude '.git' dotfiles-tmp/ $HOME/ && rm --recursive dotfiles-tmp && alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME' && config config --local status.showUntrackedFiles no
```
Note: this will install all dotfiles, suited for setting up a new machine with X enabled.
Headless machines should use ansible via $bash_dotfiles_root/meta/metafiles/execute_playbook.sh
after configuring which subset of files are desired (change role variable and user information)
