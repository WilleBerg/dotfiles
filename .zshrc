#### PLUGINS
# https://github.com/zsh-users/zsh-autosuggestions
# https://github.com/zsh-users/zsh-syntax-highlighting
# https://github.com/zdharma-continuum/fast-syntax-highlighting
# https://github.com/marlonrichert/zsh-autocomplete
#
# THIS LINK FOR INSTALL OF ALL **EXCEPT** AUTOCOMPLETE.
# DO THAT MANUALLY FOR MUCH FASTER START
#
# https://gist.github.com/n1snt/454b879b8f0b7995740ae04c5fb5b7df
#### AUTOCOMPLETE ##############################################################
source ~/zsh_plugins/zsh-autocomplete/zsh-autocomplete.plugin.zsh
bindkey '\t' menu-select "$terminfo[kcbt]" menu-select
bindkey -M menuselect '\t' menu-complete "$terminfo[kcbt]" reverse-menu-complete

zstyle ':completion:*' menu select
zmodload zsh/complist
# use the vi navigation keys in menu completion
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history

alias obsidian="/home/sylt/Obsidian-1.4.13.AppImage"
alias grammar="git add *; git commit -m "grammar"; git push"
alias p3="python3"

export PATH=$HOME/bin:/usr/local/bin:$PATH
PATH=/home/sylt/.local/bin:/usr/local/texlive/2022/bin/x86_64-linux:/home/sylt/.local/bin:/home/sylt/.nvm/versions/node/v18.12.1/bin:/usr/local/texlive/2022/bin/x86_64-linux:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/snap/bin
PATH=$PATH:"/home/sylt/.cargo/bin"
PATH=$PATH:"/usr/bin/"

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"
#### THEME #####################################################################
ZSH_THEME="half-life"
################################################################################

ENABLE_CORRECTION="true"
##### PLUGINS ##################################################################
plugins=(git
    zsh-autosuggestions
    zsh-syntax-highlighting
    fast-syntax-highlighting
)
# Bind Ctrl+Tab to autosuggest-accept
bindkey '^ ' autosuggest-accept

################################################################################

source $ZSH/oh-my-zsh.sh


[ -f "/home/sylt/.ghcup/env" ] && source "/home/sylt/.ghcup/env" # ghcup-env
eval "$(zoxide init zsh)"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

alias l="ls -la"
export PATH="$HOME/sw/nvim-linux64/bin:$PATH"
