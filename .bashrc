#!/usr/bin/env bash

source ~/.config/dotfiles/bash/bashrc.sh
# source ~/new_dotfiles/bash/bashrc.sh

# source ~/new_dotfiles/bash/old_bashrc.sh

# for emergency revert to old bashrc
alias old_bashrc='source ~/.config/dotfiles/bash/old_bashrc.sh'


non_fasd_bashrc(){
    head -n-13 ~/.bashrc
}


# for some reason fasd only works in bashrc in this order
fasd_cache="$HOME/.fasd-init-bash"
if [ "$(command -v fasd)" -nt "$fasd_cache" -o ! -s "$fasd_cache" ]; then
    fasd --init posix-alias bash-hook bash-ccomp bash-ccomp-install >| "$fasd_cache"
fi
source "$fasd_cache"
unset fasd_cache
_fasd_bash_hook_cmd_complete v m j o z

# aliases which depend on fasd
alias z=fuzzy_z
alias o=fuzzy_xdgopen
alias sf=ssf

[ -f ~/.fzf.bash ] && source ~/.fzf.bash
