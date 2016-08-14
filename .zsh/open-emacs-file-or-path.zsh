#!/bin/zsh

export EDITOR="/usr/local/bin/emacsclient"

pwd=$1
path=$2
lineno=$3

if [[ "$path" =~ ^[^/] ]]; then
   path="${pwd}${path}"
fi

if [ -n "$lineno" ]; then
   lineno="+$lineno"
fi

$EDITOR --quiet --alternate-editor=nano --no-wait $lineno $path > /tmp/clicklog 2>&1
