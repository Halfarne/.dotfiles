#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias c="clear"

alias please='doas'
alias sudo="doas"

PS1='[\u@\h \W]\$ '
eval "$(starship init bash)"

complete -cf doas
