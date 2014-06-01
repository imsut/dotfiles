#!/bin/sh

export CLICOLOR_FORCE=1
#export GREP_OPTIONS='--color=always'
export LESS='-R'
export LESSOPEN='| /usr/local/bin/source-highlight --failsafe -f esc -i %s -o STDOUT'
export MANPATH=$MANPATH:/opt/local/share/man
export PAGER=less
export PATH=$HOME/local/bin:$HOME/bin:$HOME/cabal-dev/bin:/usr/local/bin:/Users/kentaro/.rvm/:$PATH
export SBT_OPTS=-XX:MaxPermSize=256m

if [ -f "$HOME/.zprofile.local" ]; then
  source "$HOME/.zprofile.local"
fi
