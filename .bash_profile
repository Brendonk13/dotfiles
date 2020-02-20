#
# ~/.bash_profile
#

[[ -f ~/.bashrc ]] && . ~/.bashrc

# opam configuration
test -r /home/brendon/.opam/opam-init/init.sh && . /home/brendon/.opam/opam-init/init.sh > /dev/null 2> /dev/null || true

export BROWSER=/usr/bin/google-chrome-stable
