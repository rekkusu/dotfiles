# Set up the prompt
bindkey -e
setopt no_flow_control

autoload -Uz promptinit && promptinit
autoload -Uz colors && colors
autoload -Uz vcs_info
autoload -Uz add-zsh-hook
setopt prompt_subst

function _installed {
  return $(whence $1 &> /dev/null)
}

typeset -U path PATH
function add_path {
  path=($1 $path)
}

function add_path_if_exists {
  if [[ -e $1 ]]; then
    add_path $1
  fi
}

# buffer stack
show_buffer_stack() {
  buffer_stack=$'\n'"%F{248}> $LBUFFER%f"
  zle push-line-or-edit
  zle reset-prompt
}

clear_buffer_stack() {
    buffer_stack=''
}

add-zsh-hook precmd clear_buffer_stack
zle -N show_buffer_stack
bindkey "^q" show_buffer_stack

zstyle ':vcs_info:git:*' check-for-changes true
zstyle ':vcs_info:git:*' stagedstr "%{$fg[yellow]%}!%{$reset_color%}"
zstyle ':vcs_info:git:*' unstagedstr "%{$fg[yellow]%}+%{$reset_color%}"
zstyle ':vcs_info:*' formats "%{$fg[white]%}(%b)%{$reset_color%} "
zstyle ':vcs_info:*' actionformats '[%b|%a]'

function pre_vcs_info() {
  vcs_info
}
add-zsh-hook precmd pre_vcs_info

function prompt_host() {
    if [[ -f /etc/os-release ]]; then
        local id=$(grep "^ID=" /etc/os-release | cut -d '=' -f 2 | tr -d '"')
        case $id in
            ubuntu ) prompt_host_msg=$'\uf31b $HOST';;
            arch ) prompt_host_msg=$'\uf303 $HOST';;
            * ) prompt_host_msg=$'\uf31a $HOST';;
        esac
    else
        prompt_host_msg=$'\uf31a $HOST'
    fi
}
prompt_host

PROMPT=""
PROMPT+="%{$fg[red]%}[%*]%{$reset_color%}"  # timestamp
PROMPT+=" %{$fg[cyan]%}$prompt_host_msg%{$reset_color%}"  # host
PROMPT+=" %?"  # status
PROMPT+=' ${vcs_info_msg_0_}'  # Zsh VCS
PROMPT+="%{$fg[green]%}%~%{$reset_color%}"  # current directory
PROMPT+='${buffer_stack}'
PROMPT+=$'\n'"%% "

HISTSIZE=10000
SAVEHIST=10000
HISTFILE="$XDG_STATE_HOME"/.zsh_history
setopt histignorealldups

source `dirname $0`/local.zsh

