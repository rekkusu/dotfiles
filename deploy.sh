#!/bin/sh
cd `dirname $0`

if [[ ! -e $HOME/.zshrc ]]; then
  ln -sr ./zshrc $HOME/.zshrc
  echo "[+] Created symlink of .zshrc"
fi

if [[ ! -d $HOME/.config/nvim ]]; then
  ln -sr ./config/nvim $HOME/.config/nvim
  echo "[+] Created symlink of .config/nvim"
fi

if [[ ! -d $HOME/.tmux.conf ]]; then
  ln -sr ./tmux.conf $HOME/.tmux.conf
  echo "[+] Created symlink of .tmux.conf"
fi

# for WSL
if [[ `uname -r` =~ .*WSL.* ]]; then
  if [[ -z WINHOME ]];
    export WINHOME=/mnt/c/Users/rex
  fi

  cp "$WINHOME/Application Data/wsltty/config" "$WINHOME/Application Data/wsltty/config.bak"
  cp wsl/wsltty/config "$WINHOME/Application Data/wsltty/config"

  cp "$WINHOME/Application Data/wsltty/config" "$WINHOME/Application Data/wsltty/config.bak"
  cp wsl/wsltty/themes/favorite "$WINHOME/Application Data/wsltty/config"
fi
