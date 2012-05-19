# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=100000
SAVEHIST=100000
bindkey -e
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall

autoload -Uz compinit
compinit
# End of lines added by compinstall

autoload -U colors
colors

fpath=(~/.zsh/functions $fpath)
autoload -U ~/.zsh/functions/*(:t)

setopt share_history
setopt auto_cd
setopt auto_param_keys
setopt equals
setopt noautoremoveslash
setopt PROMPT_SUBST
unsetopt auto_menu

#
# Aliases
#
alias la='ls -lAhG '
alias glogg='git log --graph --date-order --pretty=format:"%h (%an) %s %cd" --branches'

#
# Hooks
#
typeset -ga preexec_functions
typeset -ga precmd_functions
typeset -ga chpwd_functions

case "$TERM" in
screen)
  preexec_functions+='preexec_update_screen_status'
  ;;
esac

preexec_functions+='preexec_update_git_vars'
precmd_functions+='precmd_update_git_vars'
chpwd_functions+='chpwd_update_git_vars'
chpwd_functions+='chpwd_show_files'

#
# PROMPT / RPROMPT
#
PROMPT=$'%{${fg[cyan]}%}%m%{${fg[black]}%}:%{${fg[blue]}%}%B%~%b%{${fg[default]}%}%% '
RPROMPT=$'$(prompt_git_info)%{${fg[default]}%} [%*]'


if [ -f "$HOME/.zshrc.local" ]; then
  source "$HOME/.zshrc.local"
fi
