
# HSTR configuration - add this to ~/.bashrc
alias hh=hstr                    # hh to be alias for hstr
export HSTR_CONFIG=hicolor       # get more colors
shopt -s histappend              # append new history items to .bash_history
export HISTCONTROL=ignorespace   # leading space hides commands from history
export HISTFILESIZE=10000        # increase history file size (default is 500)
export HISTSIZE=${HISTFILESIZE}  # increase history size (default is 500)
# ensure synchronization between Bash memory and history file
export PROMPT_COMMAND="history -a; history -n; ${PROMPT_COMMAND}"
# if this is interactive shell, then bind hstr to Ctrl-r (for Vi mode check doc)
if [[ $- =~ .*i.* ]]; then bind '"\C-r": "\C-a hstr -- \C-j"'; fi
# if this is interactive shell, then bind 'kill last command' to Ctrl-x k
if [[ $- =~ .*i.* ]]; then bind '"\C-xk": "\C-a hstr -k \C-j"'; fi

# lscolor's project by geoff greer
#LS_COLORS=$LS_COLORS:'di=1;34;47:ln=35:so=32:pi=33:ex=31:bd=34;46:cd=34;43:su=30;41:sg=30;46:tw=30;42:ow=30;43'
#export LS_COLORS='di=1;34;47:ln=35:so=32:pi=33:ex=31:bd=34;46:cd=34;43:su=30;41:sg=30;46:tw=30;42:ow=30;43'

# what's left: remove the follow and g options and no-ignore in fzf default
# figure out what default ops means exxactly by trying
# then delete the -g things in sf command,
# delete more options incrementally by testing on the command line till it works



[ -f ~/.fzf.bash ] && source ~/.fzf.bash
# options like --hidden and --smart-case are specified as rg defaults in ~/FromInternet/.ripgreprc
export FZF_DEFAULT_COMMAND='rg --files'
export FZF_ALT_C_COMMAND="bfs -type d -nohidden"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_DEFAULT_OPTS='--bind J:down,K:up --reverse --ansi --multi'
bind -x '"\C-p": vim $(fzf);'
#bind -x '"\C-p": fvim'
# the commented one is in bag-man's vimrc, it calls a function im not gunna add cuz i dont have tmux, yet.
# the one i replaced was in his first blog post

# the --no-ignore means we're searching thru .gitignore's!
# the --follow flag means we're following symlinks!
# maybe need to change to --color 'always' -- changing quotes basically
# the --fixed-string thing means that we can't search using regex!

### need to look into the --fixed-strings mode more, think it could be kinda sick!

sf() {
    if [ "$#" -lt 1 ]; then echo "Supply string to search for!"; return 1; fi
    printf -v search "%q" "$*"
    #include="yml,js,json,php,md,styl,pug,jade,html,config,py,cpp,c,go,hs,rb,conf,fa,lst"
    #exclude=".config,.git,node_modules,vendor,build,yarn.lock,*.sty,*.bst,*.coffee,dist"
    rg_command='rg --column --line-number --no-heading --fixed-strings --color "always"'
    files=`eval $rg_command $search | fzf --ansi --multi --reverse | awk -F ':' '{print $1":"$2":"$3}'`
    [[ -n "$files" ]] && ${EDITOR:-nvim} $files
}
