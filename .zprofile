#!/bin/sh

export CLICOLOR_FORCE=1
export GREP_OPTIONS='--color=always'
export LESS='-R'
export LESSOPEN='| /usr/local/bin/source-highlight -f esc -i %s -o STDOUT'
export MANPATH=$MANPATH:/opt/local/share/man
export PAGER=less
export PATH=$HOME/local/bin:$HOME/bin:$HOME/cabal-dev/bin:/usr/local/bin:$PATH
export SBT_OPTS=-XX:MaxPermSize=256m

ssh_agent_sock=$HOME/ssh-agent-$USER
if [ -S "$SSH_AUTH_SOCK" ]; then
  ln -snf "$SSH_AUTH_SOCK" $ssh_agent_sock
  export SSH_AUTH_SOCK=$ssh_agent_sock
elif [ -S "$ssh_agent_sock" -a -L "$ssh_agent_sock" ]; then
  export SSH_AUTH_SOCK=$ssh_agent_sock
else
  echo "no ssh-agent"
fi

if [ -f "$HOME/.zprofile.local" ]; then
  source "$HOME/.zprofile.local"
fi
