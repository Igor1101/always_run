echo "user code is running..."
source conf.sh
# write here your usercode

#
# the end, kill session if don`t need to repeat
tmux kill-session -t $TMUX_SESSION
