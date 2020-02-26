#!/bin/sh

export CLICOLOR_FORCE=1
export LESS='-R'
#export LESSOPEN='| /usr/local/bin/source-highlight --failsafe -f esc -i %s -o STDOUT'
export MANPATH=$MANPATH:/opt/local/share/man
export PAGER=less
export EDITOR=vim
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/pulse
export CLOUDSDK_PYTHON=python3
 
export PATH=$HOME/local/bin:$HOME/bin:$PATH:/usr/local/bin:$HOME/go/bin
export PATH=$PATH:$HOME/google-cloud-sdk/bin
export PATH=$PATH:$HOME/anaconda3/bin
export PATH=$PATH:$HOME/Library/Python/3.6/bin
export PATH=$PATH:/usr/local/go/bin

if [ -f "$HOME/.zprofile.local" ]; then
  source "$HOME/.zprofile.local"
fi

source /opt/ros/melodic/setup.zsh


export PATH="$HOME/.cargo/bin:$PATH"
