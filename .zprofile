#!/bin/sh

export CLICOLOR_FORCE=1
export LESS='-R'
#export LESSOPEN='| /usr/local/bin/source-highlight --failsafe -f esc -i %s -o STDOUT'
export MANPATH=$MANPATH:/opt/local/share/man
export PAGER=less
export EDITOR=vim

export PATH=$PATH:$HOME/local/bin:$HOME/bin:$HOME/.local/bin:/usr/local/bin:$HOME/go/bin
export PATH=$PATH:$HOME/google-cloud-sdk/bin:
export PATH=$PATH:$HOME/anaconda3/bin

if [ -f "$HOME/.zprofile.local" ]; then
  source "$HOME/.zprofile.local"
fi
