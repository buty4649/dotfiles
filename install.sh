#!/bin/bash

set -e

WORKDIR="$(cd `dirname $0`; pwd)"

git submodule init
git submodule update

find root/ -mindepth 1 -maxdepth 1 -type d -or -type f |
xargs -L1 -I%DIR% bash -c "ln -s $WORKDIR/%DIR% $HOME/\$(basename %DIR%)"
