#!/bin/bash

set -xe

MITAME_VERSION=v1.11.7
SUDO_PROMPT='[local sudo] Password: '


if ! which mitamae > /dev/null; then
    sudo -p "$SUDO_PROMPT" bash -c "\
        wget -O /usr/local/bin/mitamae https://github.com/itamae-kitchen/mitamae/releases/download/${MITAME_VERSION}/mitamae-x86_64-linux && \
        chmod +x /usr/local/bin/mitamae"
fi

sudo -p "$SUDO_PROMPT" mitamae local $* roles/ubuntu/root.rb "$*"
mitamae local $* roles/ubuntu/user.rb "$*"
