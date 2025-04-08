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

if ! which mitamae > /dev/null; then
    BIN_DIR="$HOME/.local/bin"
    mkdir -p "$BIN_DIR"

    MITAMAE_BIN="${BIN_DIR}/mitamae"
    MITAME_VERSION=$(curl -s https://api.github.com/repos/itamae-kitchen/mitamae/releases/latest | awk -F: '/"name"/{print $2;exit}' | tr -d '", ')

    curl -sL "https://github.com/itamae-kitchen/mitamae/releases/download/${MITAME_VERSION}/mitamae-x86_64-linux" -o "$MITAMAE_BIN"
    chmod +x "$MITAMAE_BIN"
fi

SUDO_PROMPT='[local sudo] Password: '
if ! which git > /dev/null; then
    sudo -p "$SUDO_PROMPT" apt-get install -y git
fi

REPODIR="${HOME}/.local/share/chezmoi"
if [ ! -d "$REPODIR" ]; then
    git clone --recursive --depth 1 https://github.com/buty4649/dotfiles.git "$REPODIR"
fi
cd "${REPODIR}/bootstrap"

PATH=$HOME/.local/bin:$PATH mitamae local $* roles/${PLATFORM}.rb -y <(cat <<__YAML__
username: ${USER}
homedir: ${HOME}
__YAML__
)
