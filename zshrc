# Set up the prompt

autoload -Uz promptinit && promptinit
autoload -U colors && colors
autoload -Uz vcs_info
autoload -Uz add-zsh-hook
setopt prompt_subst

typeset -U path PATH
function add_path {
  path=($1 $path)
}

function add_path_if_exists {
  if [[ -e $1 ]]; then
    add_path $1
  fi
}

function _installed {
  return $(whence $1 &> /dev/null)
}

zstyle ':vcs_info:git:*' check-for-changes true
zstyle ':vcs_info:git:*' stagedstr "%{$fg[yellow]%}!%{$reset_color%}"
zstyle ':vcs_info:git:*' unstagedstr "%{$fg[yellow]%}+%{$reset_color%}"
zstyle ':vcs_info:*' formats "%{$fg[white]%}(%b)%{$reset_color%}"
zstyle ':vcs_info:*' actionformats '[%b|%a]'

function pre_vcs_info() {
  vcs_info
}
add-zsh-hook precmd pre_vcs_info

vcs_info_msg_0_="A"
PROMPT=""
PROMPT+="%{$fg[red]%}[%*]%{$reset_color%}"  # timestamp
PROMPT+=" %{$fg[cyan]%}$HOST%{$reset_color%}"  # host
PROMPT+=" %?"  # status
PROMPT+=' ${vcs_info_msg_0_}'  # Zsh VCS
PROMPT+=" %{$fg[green]%}%~%{$reset_color%}"  # current directory
PROMPT+="
%% "  # shell


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

setopt histignorealldups

# Use emacs keybindings even if our EDITOR is set to vi
bindkey -e

HISTSIZE=10000
SAVEHIST=10000
HISTFILE=~/.zsh_history

autoload -Uz compinit && compinit

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

# aliases
alias ls='ls --color'

if _installed fcitx; then
  export GTK_IM_MODULE=fcitx
  export QT_IM_MODULE=fcitx
  export XMODIFIERS="@im=fcitx"
  export DefaultIMModule=fcitx
fi

add_path_if_exists $HOME/bin
add_path_if_exists $HOME/appimage

if _installed nvim; then
  export EDITOR='nvim'
fi

# nodebrew
add_path_if_exists $HOME/.nodebrew/current/bin
if _installed nodebrew; then
fi

# wsl2-ssh-pageant
function start-agent() {
  ss -a | grep -q $SSH_AUTH_SOCK
  if [ $? -ne 0 ]; then
    rm -f $SSH_AUTH_SOCK
    (setsid nohup socat UNIX-LISTEN:$SSH_AUTH_SOCK,fork EXEC:"$HOME/.ssh/wsl2-ssh-pageant.exe -logfile /dev/null" >/dev/null 2>&1 &)
  fi

  ss -a | grep -q $GPG_AGENT_SOCK
  if [ $? -ne 0 ]; then
    rm -rf $GPG_AGENT_SOCK
    (setsid nohup socat UNIX-LISTEN:$GPG_AGENT_SOCK,fork EXEC:"$HOME/.ssh/wsl2-ssh-pageant.exe -logfile /dev/null --gpg S.gpg-agent" >/dev/null 2>&1 &)
  fi
}

if [[ `uname -r` =~ .*WSL.* ]]; then
  export WINHOME=/mnt/c/Users/rex
  export SSH_AUTH_SOCK=$HOME/.ssh/agent.sock
  export GPG_AGENT_SOCK=$HOME/.gnupg/S.gpg-agent
  start-agent
fi

### Google depot_tools
add_path_if_exists $HOME/src/depot_tools

### Go
if _installed go; then
  export GOPATH=$HOME/go
  add_path_if_exists $GOPATH/bin
fi

#### asdf
if [[ -e "$HOME/.asdf/asdf.sh" ]]; then
  . $HOME/.asdf/asdf.sh
fi

### pyenv
add_path_if_exists $HOME/.pyenv/bin
if _installed pyenv; then
  eval "$(pyenv init -)"
  eval "$(pyenv virtualenv-init -)"
fi

if [ -e /home/rex/.nix-profile/etc/profile.d/nix.sh ]; then . /home/rex/.nix-profile/etc/profile.d/nix.sh; fi # added by Nix installer

