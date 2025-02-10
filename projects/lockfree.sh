#!/bin/bash
if tmux has-session -t lockfree 2>/dev/null; then
    tmux switch-client -t lockfree 
else
    cd $HOME/lockfree-benchmark
    tmux new-session -d -s lockfree
    tmux split-window -h
    tmux resize-pane -R 50
    tmux select-pane -t 1
    tmux send-keys -t lockfree:1.1 'nvim src/lib.rs' C-m
    tmux new-window -t lockfree:2
    tmux send-keys -t lockfree:2 'nvim Cargo.toml' C-m
    tmux select-window -t 1
    tmux attach-session -t lockfree
fi
