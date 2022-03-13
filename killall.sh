#!/bin/sh
source conf.sh
# please don`t edit these:
USERNAME=$1
PASSWORD=$2
SSH_COMMAND="tmux kill-session -t $TMUX_SESSION"
# file_hosts data format:
# X.X.X.X
file_hosts='hosts.txt'
n=1
while IFS= read -r line
do
    host=$line
    echo "linenum(host): $n:$host:"
    # show session for each host
    sshpass -p $PASSWORD ssh -n -o StrictHostKeyChecking=no \
        -o UserKnownHostsFile=/dev/null \
        $USERNAME@$host \
        $SSH_COMMAND 
    ((n=n+1))
done < "$file_hosts"
