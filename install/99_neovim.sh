#!/bin/bash

mkdir -p $APPIMAGE_DIR
wget -O $APPIMAGE_DIR/nvim https://github.com/neovim/neovim/releases/latest/download/nvim.appimage
chmod u+x $APPIMAGE_DIR/nvim

