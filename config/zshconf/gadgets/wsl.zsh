
if [[ `uname -r` =~ .*WSL.* ]]; then
  export WINUSER=`whoami.exe | sed -r 's/^[^\]+\\\\(.+)\r$/\1/g'`
  export WINHOME=/mnt/c/Users/$WINUSER
  export SSH_SK_HELPER="/mnt/c/Program Files/OpenSSH/ssh-sk-helper.exe"
  eval $(wsl2-ssh-agent)
fi

