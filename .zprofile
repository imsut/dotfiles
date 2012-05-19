#!/bin/sh

export MANPATH=$MANPATH:/opt/local/share/man
export PAGER=less
export PATH=$HOME/local/bin:$HOME/bin:$HOME/.gem/ruby/1.8/bin:/usr/local/bin:$PATH

if [ -f "$HOME/.zprofile.local" ]; then
  source "$HOME/.zprofile.local"
fi
