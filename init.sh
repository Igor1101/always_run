#!/bin/sh
sudo chmod u+x ./run.sh
sudo chmod u+x ./user_code.sh
tmux new-session -d -s "always_run"  ./run.sh
