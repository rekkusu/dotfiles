#!/bin/bash
GO_VERSION=1.20.3

wget -O /tmp/go.tar.gz https://go.dev/dl/go${GO_VERSION}.linux-amd64.tar.gz
sudo tar -C /usr/local -xzf /tmp/go.tar.gz
rm /tmp/go.tar.gz
