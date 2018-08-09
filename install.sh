#!/bin/bash

set -e

WORKDIR="$(cd `dirname $0`; pwd)"
MARCH="$(uname -s |tr '[A-Z]' '[a-z]')"

git submodule init
git submodule update

find root/ -mindepth 1 -maxdepth 1 -type d -or -type f |
while read FILENAME
do
    SRC="$WORKDIR/$FILENAME"
    DST="$HOME/$(basename "$FILENAME")"

    if [ -h "$DST" ]; then
        echo "SKIP $DST"
    elif [ -f "$DST" -o -d "$DST" ]; then
        echo "Error: file exists !! $DST"
        exit 1
    else
        ln -svf "$SRC" "$DST"
    fi
done

# bin配下をコピー
mkdir -p "${HOME}/bin"
find bin/ -mindepth 1 -maxdepth 1 -type f |
while read FILENAME
do
    SRC="$WORKDIR/$FILENAME"
    DST="$HOME/bin/$(basename "$FILENAME")"
    ln -svf "$SRC" "$DST"
done

[ -x "./install_${MARCH}.sh" ] && ./install_${MARCH}.sh
