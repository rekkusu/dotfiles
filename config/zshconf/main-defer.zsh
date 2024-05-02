
autoload -Uz edit-command-line
zle -N edit-command-line
bindkey '^xe' edit-command-line


AUTOLS_LIMIT=100
autols() {
  lines=`ls | wc -l`
  if [ $lines -le $AUTOLS_LIMIT ]; then
    ls --color
  fi
}

add-zsh-hook chpwd autols

# refresh timestamp
re-prompt() {
    zle .reset-prompt
    zle .accept-line
}

zle -N accept-line re-prompt


autoload -Uz compinit && compinit -d "$XDG_CACHE_HOME"/zsh/zcompdump

zstyle ':completion:*' completer _complete _prefix
zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z} r:|[-_.]=**'

zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
zstyle ':completion:*:kill:*' command 'ps -u $USER -o pid,%cpu,tty,cputime,cmd'

setopt auto_pushd
setopt pushd_ignore_dups
zstyle ':completion:*' menu select
zstyle ':completion:*:cd:*' ignore-parents parent pwd

# enable completion after equals
setopt magic_equal_subst


if _installed nvim; then
  export EDITOR='nvim'
fi

add_path_if_exists $HOME/.local/bin
add_path_if_exists $HOME/bin

# zsh autosuggest
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#888888,underline"

# aliases
alias ls='ls --color'


source `dirname $0`/local-defer.zsh
