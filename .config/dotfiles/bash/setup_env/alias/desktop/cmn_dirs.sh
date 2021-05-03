#!/usr/bin/env bash

# ------ Common directory navigation ---------------------------------------
alias dow='cd "$dow"; lsd --group-dirs first'
alias submit='cd "$submit"; lsd --group-dirs first'
alias sem='cd "$sem"; lsd --group-dirs first'
alias scrot='cd ~/Pictures/Screenshots; lsd --group-dirs first; ranger'


# ------ Course directories ------------------------------------------------
alias cam='cd ~/Documents/Mcgill/5th-year/Winter/Compilers/Ocaml; lsd --group-dirs first'
alias 326='cd "$sem";  cd 326;             lsd --group-dirs first'
alias 321='cd "$sem";  cd Prog_challenges; lsd --group-dirs first'
alias 429='cd "$sem";  cd 429;             lsd --group-dirs first'
alias chem='cd "$sem"; cd Chem;            lsd --group-dirs first'
alias atmo='cd "$sem"; cd Atmosphere;      lsd --group-dirs first'


# ------ Random directories ------------------------------------------------
# mnemonic:  EclipseWorkspace
alias ework='cd /home/brendon/Downloads/programs/eclipse-workspace; lsd --group-dirs first'
alias print='cd ~/Scripts/my_projects/print; lsd --group-dirs first'

alias eclipse='cd /home/brendon/Downloads/programs/java-2019-06/eclipse; ./eclipse &'

alias mnt='cd /mnt/home/brendon'
