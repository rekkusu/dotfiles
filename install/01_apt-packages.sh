#!/bin/bash

PACKAGES=(
  # required
  socat
  git
  libfuse2  # for appimage

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
sudo apt install $PACKAGES
