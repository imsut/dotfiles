# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=10000
SAVEHIST=10000
bindkey -e
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall

autoload -Uz compinit
compinit -u
# End of lines added by compinstall

autoload -U colors
colors

fpath=(/usr/local/share/zsh-completions $fpath)
fpath=(~/.zsh/functions $fpath)
autoload -U ~/.zsh/functions/*(:t)

setopt share_history
setopt auto_cd
setopt auto_param_keys
setopt equals
setopt noautoremoveslash
setopt PROMPT_SUBST
setopt nullglob
setopt HIST_IGNORE_ALL_DUPS
unsetopt auto_menu

#
# Aliases
#
alias la='/bin/ls -lAhG '
alias e='emacsclient -n '
alias g='kinit; git '
alias glogg='git log --graph --date-order --pretty=format:"%h (%an) %s %cd" --branches'
alias br='git branch'
alias st='git status'
alias attach='$HOME/bin/grabssh.sh; screen -d -R'
alias fixssh='source $HOME/bin/fixssh'
alias pycheck='pants py src/python/twitter/checkstyle:check --diff=$(git merge-base HEAD master)'
alias -g L='| less '
alias -g JP='| json_pp | less '

#
# Hooks
#
typeset -ga preexec_functions
typeset -ga precmd_functions
typeset -ga chpwd_functions

case "$TERM" in
screen)
  #preexec_functions+='preexec_update_screen_status'
  ;;
esac

preexec_functions+='preexec_update_git_vars'
precmd_functions+='precmd_update_git_vars'
chpwd_functions+='chpwd_update_git_vars'
chpwd_functions+='chpwd_show_files'

#
# PROMPT / RPROMPT
#
PROMPT=$'%{${fg[green]}%}%m%{${fg[default]}%}=; cd %{${fg[blue]}%}%~%{${fg[default]}%};$(prompt_git_info) '
#RPROMPT=$'$(prompt_git_info)%{${fg[default]}%} [%*]'

if [ -f "$HOME/.zshrc.local" ]; then
  source "$HOME/.zshrc.local"
fi

#
# percol
#
function exists { which $1 &> /dev/null }

if exists percol; then
    function percol_select_history() {
        local tac
        exists gtac && tac="gtac" || { exists tac && tac="tac" || { tac="tail -r" } }
        BUFFER=$(history -n 1 | eval $tac | percol)
#        BUFFER=$(history -n 1 | sort -u | percol --query "$LBUFFER")
        CURSOR=$#BUFFER         # move cursor
        zle -R -c               # refresh
    }

    zle -N percol_select_history
    bindkey '^R' percol_select_history
fi
PHP_AUTOCONF="/usr/local/bin/autoconf"

test -e ${HOME}/.iterm2_shell_integration.zsh && source ${HOME}/.iterm2_shell_integration.zsh
