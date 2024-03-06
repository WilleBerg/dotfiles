#
# ~/.bashrc
#

PATH=$PATH:~/.cargo/bin
# If not running interactively, don't do anything
[[ $- != *i* ]] && return

neofetch --disable memory cpu gpu theme icons

alias ls='ls --color=auto'
alias grep='grep --color=auto'
PS1='[\u@\h \W]\$ '
. "$HOME/.cargo/env"
PATH=$PATH:"/home/jam/Documents/Code/fsearch/target/release" # ADDED BY FSEARCH INSTALL SCRIPT AT Thu Oct 19 18:02:24 CEST 2023

[ -f ~/.fzf.bash ] && source ~/.fzf.bash
