#!/bin/sh
tmux kill-session -t "always_run"
tmux new-session -d -s "always_run"  bash run.sh
