#!/bin/sh

export CLICOLOR_FORCE=1
#export GREP_OPTIONS='--color=always'
export LESS='-R'
#export LESSOPEN='| /usr/local/bin/source-highlight --failsafe -f esc -i %s -o STDOUT'
export MANPATH=$MANPATH:/opt/local/share/man
export PAGER=less
export PATH=$HOME/local/bin:$HOME/bin:$HOME/.local/bin:$HOME/cabal-dev/bin:/usr/local/bin:/Users/kentaro/.rvm:$PATH
#export DYLD_LIBRARY_PATH=/Users/kentaro/local/lib

#export JAVA_TOOL_OPTIONS="-Dfile.encoding=utf8"
#export MAVEN_OPTS="-Xmx2048m -XX:MaxPermSize=256m"

export EDITOR=vim

if [ -f "$HOME/.zprofile.local" ]; then
  source "$HOME/.zprofile.local"
fi
