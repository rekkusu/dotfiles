#!/bin/bash

if [[ `uname -r` =~ .*WSL.* ]]; then
  echo "[+] Install wsl2-ssh-pageant"
  WSL2_SSH_PAGEANT=$HOME/.ssh/wsl2-ssh-pageant.exe

  sudo apt-get install socat git

  if [[ ! -e $WSL2_SSH_PAGEANT ]]; then
    wget -O $WSL2_SSH_PAGEANT https://github.com/BlackReloaded/wsl2-ssh-pageant/releases/download/v1.4.0/wsl2-ssh-pageant.exe
  fi

  setsid nohup socat UNIX-LISTEN:$SSH_AUTH_SOCK,fork EXEC:"$WSL2_SSH_PAGEANT -logfile /dev/null" >/dev/null 2>&1 &
fi
