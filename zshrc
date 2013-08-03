# adds the current branch name in green
git_prompt_info() {
  ref=$(git symbolic-ref HEAD 2> /dev/null)
  if [[ -n $ref ]]; then
    echo "[%{$fg_bold[green]%}${ref#refs/heads/}%{$reset_color%}]"
  fi
}

# makes color constants available
autoload -U colors
colors

# enable colored output from ls, etc
export CLICOLOR=1

# completion
autoload -U compinit
compinit

# load our own completion functions
fpath=(~/.zsh/completion $fpath)

for function in ~/.zsh/functions/*; do
  source $function
done

# expand functions in the prompt
setopt prompt_subst

# automatically enter directories without cd
setopt auto_cd

# use vim as the visual editor
export VISUAL=vim
export EDITOR=$VISUAL

# vi mode
bindkey -v
bindkey "^F" vi-cmd-mode
bindkey jj vi-cmd-mode

# use incremental search
bindkey "^R" history-incremental-search-backward

# add some readline keys back
bindkey "^A" beginning-of-line
bindkey "^E" end-of-line

# handy keybindings
bindkey "^P" history-search-backward
bindkey "^Y" accept-and-hold
bindkey "^N" insert-last-word
bindkey -s "^T" "^[Isudo ^[A" # "t" for "toughguy"

# prompt
export PS1='$(git_prompt_info)[${SSH_CONNECTION+"%{$fg_bold[green]%}%n@%m:"}%{$fg_bold[blue]%}%1~%{$reset_color%}] '

# command history store
setopt append_history inc_append_history hist_ignore_all_dups

HISTFILE=~/.zhistory
SAVEHIST=4096
HISTSIZE=4096

# ignore duplicate history entries
setopt histignoredups

# look for ey config in project dirs
export EYRC=./.eyrc

# automatically pushd
setopt auto_pushd
export dirstacksize=5

# awesome cd movements from zshkit
setopt AUTOCD
setopt AUTOPUSHD PUSHDMINUS PUSHDSILENT PUSHDTOHOME
setopt cdablevars

# Enable extended globbing
setopt EXTENDED_GLOB

# Tab complete globs
setopt GLOB_COMPLETE

export GOPATH=$HOME/code/personal/go-lab
export PATH=$HOME/.bin:$PATH:/usr/local/mysql/bin

# aliases
[[ -f ~/.aliases ]] && source ~/.aliases

# Local config
[[ -f ~/.zshrc.local ]] && source ~/.zshrc.local

# Enable rbenv shims
if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi

# Enable Autojump
[[ -s `brew --prefix`/etc/autojump.sh ]] && . `brew --prefix`/etc/autojump.sh
