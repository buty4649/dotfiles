#!/bin/bash

set -xe

if [[ $(uname -r) =~ WSL2$ ]]; then
    PLATFORM=wsl2
elif grep -q 'NAME="Ubuntu'; then
    PLATFORM=ubuntu
else
    echo "Unkwon platform"
    exit 1
fi

MITAME_VERSION=v1.14.0
SUDO_PROMPT='[local sudo] Password: '

if ! which mitamae > /dev/null; then
    sudo -p "$SUDO_PROMPT" bash -c "\
        wget -O /usr/local/bin/mitamae https://github.com/itamae-kitchen/mitamae/releases/download/${MITAME_VERSION}/mitamae-x86_64-linux && \
        chmod +x /usr/local/bin/mitamae"
fi

if ! which git > /dev/null; then
    sudo -p "$SUDO_PROMPT" apt-get install -y git
fi

REPODIR="${HOME}/src/github.com/buty4649"
mkdir -p "$REPODIR"
cd "$REPODIR"
if [ ! -d dotfiles ]; then
    git clone --recursive --depth 1 https://github.com/buty4649/dotfiles.git
fi
cd dotfiles

mitamae local $* roles/${PLATFORM}.rb
