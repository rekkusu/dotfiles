#!/bin/bash
cd `dirname "$0"`

if [[ ! -e $HOME/.zshenv ]]; then
  ln -sr ./zshenv $HOME/.zshenv
  echo "[+] Created symlink of .zshenv"
fi

CONFIGS=$(ls -1 config)
for CONFIG in $(ls -1 config); do
  if [[ ! -d $HOME/.config/$CONFIG ]]; then
    ln -sr ./config/$CONFIG $HOME/.config/$CONFIG
    echo "[+] Created symlink of .config/$CONFIG"
  else
    echo "[-] $HOME/.config/$CONFIG is already existing"
  fi
done

if [[ ! -e $HOME/.tmux.conf ]]; then
  ln -sr ./tmux.conf $HOME/.tmux.conf
  echo "[+] Created symlink of .tmux.conf"
fi

