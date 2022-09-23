#!/bin/bash

PYTHON_VERSION=3.10.2

PACKAGES=(
  # required
  socat
  git

  # python build
  zlib1g-dev
  libreadline-dev
  libsqlite3-dev
  libbz2-dev
  libffi-dev
  libssl-dev
  liblzma-dev

  # optional
  build-essential
  gdb-multiarch
  tmux
  sagemath
  qemu-system-arm
  qemu-user
)

sudo apt-get update

echo "[+] Install packages"
sudo apt install $PACKAGES

if [[ `uname -r` =~ .*WSL.* ]]; then
  echo "[+] Install wsl2-ssh-pageant"
  WSL2_SSH_PAGEANT=$HOME/.ssh/wsl2-ssh-pageant.exe

  sudo apt-get install socat git

  if [[ ! -e $WSL2_SSH_PAGEANT ]]; then
    wget -O $WSL2_SSH_PAGEANT https://github.com/BlackReloaded/wsl2-ssh-pageant/releases/download/v1.4.0/wsl2-ssh-pageant.exe
  fi

  setsid nohup socat UNIX-LISTEN:$SSH_AUTH_SOCK,fork EXEC:"$WSL2_SSH_PAGEANT -logfile /dev/null" >/dev/null 2>&1 &

fi


echo "[+] Install Docker"
sudo apt-get install  ca-certificates curl gnupg lsb-release
sudo mkdir -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

sudo apt-get update
sudo apt-get install docker-ce docker-ce-cli containerd.io docker-compose-plugin


echo "[+] Install NeoVim"
wget -O $HOME/nvim https://github.com/neovim/neovim/releases/latest/download/nvim.appimage
mkdir -p $HOME/appimage
chmod u+x $HOME/appimage/nvim


echo "[+] Install pyenv"
git clone https://github.com/pyenv/pyenv.git ~/.pyenv
export PYENV_ROOT=$HOME/.pyenv
export PATH=$PYENV_ROOT/bin:$PATH
eval "$(pyenv init -)"
git clone https://github.com/pyenv/pyenv-virtualenv.git $(pyenv root)/plugins/pyenv-virtualenv
eval "$(pyenv virtualenv-init -)"
pyenv install $PYTHON_VERSION

