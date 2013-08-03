# adds the current branch name in green
git_prompt_info() {
  ref=$(git symbolic-ref HEAD 2> /dev/null)
  if [[ -n $ref ]]; then
    echo "[%{$fg_bold[green]%}${ref#refs/heads/}%{$reset_color%}]"
  fi
}

# load our own completion functions
fpath=(~/.zsh/completion $fpath)

# completion
autoload -U compinit
compinit

for function in ~/.zsh/functions/*; do
  source $function
done

# makes color constants available
autoload -U colors
colors

# expand functions in the prompt
setopt PROMPT_SUBST

# command history store
setopt APPEND_HISTORY INC_APPEND_HISTORY HIST_IGNORE_ALL_DUPS

HISTFILE=~/.zhistory
SAVEHIST=4096
HISTSIZE=4096

# awesome cd movements from zshkit
setopt AUTO_CD AUTO_PUSHD PUSHD_MINUS PUSHD_SILENT PUSHD_TO_HOME CD_ABLE_VARS
DIRSTACKSIZE=5

# Enable extended globbing
setopt EXTENDED_GLOB

# Tab complete globs
setopt GLOB_COMPLETE

# vi mode
bindkey -v
bindkey "^F" vi-cmd-mode
bindkey jj vi-cmd-mode

# handy keybindings
bindkey "^A" beginning-of-line
bindkey "^E" end-of-line
bindkey "^R" history-incremental-search-backward
bindkey "^P" history-search-backward
bindkey "^Y" accept-and-hold
bindkey "^N" insert-last-word
bindkey -s "^T" "^[Isudo ^[A" # "t" for "toughguy"

# enable colored output from ls, etc
export CLICOLOR=1

# prompt
export PS1='$(git_prompt_info)[${SSH_CONNECTION+"%{$fg_bold[green]%}%n@%m:"}%{$fg_bold[blue]%}%1~%{$reset_color%}] '

# use vim as the visual editor
export VISUAL=vim
export EDITOR=$VISUAL

# look for ey config in project dirs
export EYRC=./.eyrc

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
