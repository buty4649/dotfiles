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

MITAME_VERSION=$(curl -s https://api.github.com/repos/itamae-kitchen/mitamae/releases/latest | awk -F: '/"name"/{print $2;exit}' | tr -d '", ')
SUDO_PROMPT='[local sudo] Password: '

if ! which mitamae > /dev/null; then
    sudo -p "$SUDO_PROMPT" bash -c "\
        wget -O /usr/local/bin/mitamae https://github.com/itamae-kitchen/mitamae/releases/download/${MITAME_VERSION}/mitamae-x86_64-linux && \
        chmod +x /usr/local/bin/mitamae"
fi

if ! which git > /dev/null; then
    sudo -p "$SUDO_PROMPT" apt-get install -y git
fi

REPODIR="${HOME}/.local/share/chezmoi"
mkdir -p "$REPODIR"
if [ ! -d "$REPODIR" ]; then
    git clone --recursive --depth 1 https://github.com/buty4649/dotfiles.git "$REPODIR"
fi
cd "${REPODIR}/bootstrap"

mitamae local $* roles/${PLATFORM}.rb
