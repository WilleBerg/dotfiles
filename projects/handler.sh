#!/bin/bash
# if [ -n "$TMUX" ]; then
#     tmux detach
# fi
/$HOME/projects/$(ls $HOME/projects | fzf --tmux 50%,50% --border-label ' Run Script ')
