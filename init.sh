#!/bin/bash
source conf.sh
tmux kill-session -t $TMUX_SESSION
tmux new-session -d -s $TMUX_SESSION  bash run.sh
