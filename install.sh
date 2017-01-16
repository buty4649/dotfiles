#!/bin/bash

set -e

WORKDIR="$(cd `dirname $0`; pwd)"

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
        ln -sv "$SRC" "$DST"
    fi
done

