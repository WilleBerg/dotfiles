#!/bin/bash
if tmux has-session -t dotfiles 2>/dev/null; then
    if [ -n "$TMUX" ]; then
        tmux switch-client -t dotfiles 
    else
        tmux attach -t dotfiles
    fi
else
    cd $HOME/dotfiles && tmux new-session -d -s dotfiles 
    tmux send-keys -t dotfiles:0.0 'nvim .' Enter
    tmux split-window -t dotfiles -h
    tmux select-pane -t 1
    if [ -n "$TMUX" ]; then
        tmux switch-client -t dotfiles
    else
        tmux attach-session -t dotfiles
    fi
fi
