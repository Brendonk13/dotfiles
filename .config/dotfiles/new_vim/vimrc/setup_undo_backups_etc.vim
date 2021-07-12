
" ============ SETUP UNDO ==========================================
if has('persistent_undo')
    if exists('$SUDO_USER')
        set noundofile
    else
        if !isdirectory(expand('$HOME/.vim/tmp/undo'))
            silent !mkdir -p $HOME/.vim/tmp/undo
            echoerr 'Created directory: $HOME/.vim/tmp/undo since it did not exist'
        endif
        set undodir=~/.vim/tmp/undo
        " actually turn on undofiles
        set undofile
    endif
endif

" ============ SETUP BACKUPS ===========================================
" root user created backups mean that non root's can no longer access backups
if exists('$SUDO_USER')
    set nobackup
    set nowritebackup
else
    if !isdirectory(expand('$HOME/.vim/tmp/backup'))
        silent !mkdir -p $HOME/.vim/tmp/backup
        echoerr 'Created directory: $HOME/.vim/tmp/backup since it did not exist'
    endif
    set backupdir=$HOME/.vim/tmp/backup
    " if first option doesn't exist, write to current directory
endif

" note i can eliminate swap files from my life with wincent/terminus
" or the plugin made by damian conway listed in potential plugin file
" don't allow root to create swap files to avoid similar headaches
" ------------ SETUP SWAPFILE ------------------------------------------
if exists('$SUDO_USER')
    set noswapfile
else
    set directory=$HOME/.vim/tmp/backup//
    set directory+=~/local/.vim/tmp/backup//
    set directory+=.
    " if first option doesn't exist, write to current directory
endif
