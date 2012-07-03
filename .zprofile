#!/bin/sh

export GREP_OPTIONS='--color=always'
export LESS='-R'
export LESSOPEN='| /usr/local/bin/source-highlight -f esc -i %s -o STDOUT'
export MANPATH=$MANPATH:/opt/local/share/man
export PAGER=less
export PATH=$HOME/local/bin:$HOME/bin:/usr/local/bin:$PATH

if [ -f "$HOME/.zprofile.local" ]; then
  source "$HOME/.zprofile.local"
fi
