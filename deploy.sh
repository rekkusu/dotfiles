#!/bin/bash
cd `dirname $0`

if [[ ! -e $HOME/.zshrc ]]; then
  ln -sr ./zshrc $HOME/.zshrc
  echo "[+] Created symlink of .zshrc"
fi

if [[ ! -d $HOME/.config/nvim ]]; then
  ln -sr ./config/nvim $HOME/.config/nvim
  echo "[+] Created symlink of .config/nvim"
fi

if [[ ! -e $HOME/.tmux.conf ]]; then
  ln -sr ./tmux.conf $HOME/.tmux.conf
  echo "[+] Created symlink of .tmux.conf"
fi

# for WSL
if [[ `uname -r` =~ .*WSL.* ]]; then
  if [[ -z WINHOME ]]; then
    export WINHOME=/mnt/c/Users/rex
  fi

  cp "$WINHOME/Application Data/wsltty/config" "$WINHOME/Application Data/wsltty/config.bak"
  cp wsl/wsltty/config "$WINHOME/Application Data/wsltty/config"
  cp wsl/wsltty/themes/favorite "$WINHOME/Application Data/wsltty/themes/favorite"

  cp wsl/alacritty/alacritty.yml "$WINHOME/AppData/Roaming/alacritty"
fi
