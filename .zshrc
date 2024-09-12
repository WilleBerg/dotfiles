zstyle ':completion:*' menu select
zmodload zsh/complist
# use the vi navigation keys in menu completion
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history

alias grammar="git add *; git commit -m "grammar"; git push"

export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"
#### THEME #####################################################################
ZSH_THEME="half-life"
################################################################################

ENABLE_CORRECTION="true"
##### PLUGINS ##################################################################
plugins=(git)

################################################################################

source $ZSH/oh-my-zsh.sh

[ -f "$HOME/.ghcup/env" ] && source "$HOME/.ghcup/env" # ghcup-env
eval "$(zoxide init zsh)"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

alias l="ls -la"
alias zshconfig="nvim $HOME/.zshrc"
alias zshsource="source $HOME/.zshrc"
export PATH="$HOME/sw/nvim-linux64/bin:$PATH"
