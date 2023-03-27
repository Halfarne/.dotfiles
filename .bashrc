#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Import colorscheme from 'wal' asynchronously
#(cat ~/.cache/wal/sequences &)

alias ls='ls --color=auto'
alias please='doas'
alias c='clear && nitch'
alias ipv6="ip -6 addr show scope global | sed -e's/^.*inet6 \([^ ]*\)\/.*$/\1/;t;d'"
alias ssh='kitty +kitten ssh'
alias nix-conf='nvim ~/.dotfiles/conf.nix && cp ~/.dotfiles/conf.nix /etc/nixos/conf.nix'

#PS1='[\u@\h \W]\$ '
eval "$(starship init bash)"

complete -cf doas
complete -cf please
