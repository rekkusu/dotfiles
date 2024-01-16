#!/bin/bash
cd `dirname "$0"`

if [[ ! -e $HOME/.zshenv ]]; then
  ln -sr ./zshenv $HOME/.zshenv
  echo "[+] Created symlink of .zshenv"
fi

if [[ ! -d $HOME/.config/nvim ]]; then
  ln -sr ./config/nvim $HOME/.config/nvim
  echo "[+] Created symlink of .config/nvim"
fi

if [[ ! -d $HOME/.config/zsh ]]; then
  ln -sr ./config/zsh $HOME/.config/zsh
  echo "[+] Created symlink of .config/zsh"
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

  mkdir -p "$WINHOME/AppData/Roaming/alacritty"
  cp wsl/alacritty/alacritty.yml "$WINHOME/AppData/Roaming/alacritty/alacritty.yml"

  mkdir -p "$WINHOME/.config/wezterm"
  cp wsl/wezterm/wezterm.lua "$WINHOME/.config/wezterm/wezterm.lua"
fi
