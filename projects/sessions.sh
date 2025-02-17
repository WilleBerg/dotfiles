#!/bin/bash

attach_to=$(tmux ls | fzf --tmux 50%,50% --border-label ' Choose session ' | cut -d':' -f1)
if [ -n "$TMUX" ]; then
    tmux switch-client -t $attach_to 
else
    tmux attach -t $attach_to
fi
