setopt HIST_IGNORE_ALL_DUPS
setopt INC_APPEND_HISTORY
HISTFILE=~/.zhistory
HISTSIZE=4096
SAVEHIST=4096

export ERL_AFLAGS="-kernel shell_history enabled"
