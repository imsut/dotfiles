#!/bin/sh

export MANPATH=$MANPATH:/opt/local/share/man
export PAGER=less
export PATH=$HOME/local/bin:$HOME/bin:/usr/local/bin:$PATH

if [ -f "$HOME/.zprofile.local" ]; then
  source "$HOME/.zprofile.local"
fi
