#!/bin/sh

set -e

ABSPATH=$(cd "$(dirname $0)"; pwd)

find $ABSPATH \
  -mindepth 1 -maxdepth 1 \
  -not \( -name README.md -o -name .git -o -name .gitmodules -o -name $(basename $0) \) \
  | xargs -I@ ln -sf @ $HOME
