
# wsl2-ssh-pageant
function start-agent() {
  ss -a | grep -q $SSH_AUTH_SOCK
  if [ $? -ne 0 ]; then
    rm -f $SSH_AUTH_SOCK
    (setsid nohup socat UNIX-LISTEN:$SSH_AUTH_SOCK,fork EXEC:"$HOME/.ssh/wsl2-ssh-pageant.exe -logfile /dev/null" >/dev/null 2>&1 &)
  fi

  WIN_GPGSOCK_BASE='C:/Users/rex/AppData/Local/gnupg'
  ss -a | grep -q $GPG_AGENT_SOCK
  if [ $? -ne 0 ]; then
    rm -rf $GPG_AGENT_SOCK
    (setsid nohup socat UNIX-LISTEN:$GPG_AGENT_SOCK,fork EXEC:"$HOME/.ssh/wsl2-ssh-pageant.exe -logfile /dev/null -gpg S.gpg-agent -gpgConfigBasepath '$WIN_GPGSOCK_BASE'" >/dev/null 2>&1 &)
  fi
}

if [[ `uname -r` =~ .*WSL.* ]]; then
  export WINUSER=`whoami.exe | sed -r 's/^[^\]+\\\\(.+)\r$/\1/g'`
  export WINHOME=/mnt/c/Users/$WINUSER
  export SSH_AUTH_SOCK=$HOME/.ssh/agent.sock
  export GPG_AGENT_SOCK=$HOME/.gnupg/S.gpg-agent
  start-agent
fi

