#!/bin/bash
source conf.sh
# please don`t edit these:
USERNAME=$1
PASSWORD=$2
SSH_COMMAND='tmux ls'
# file_hosts data format:
# X.X.X.X
file_hosts='hosts.txt'
n=1
while IFS= read -r line
do
    host="$line"
    echo "linenum(host): $n:$host:"
    # show session for each host
    sshpass -p $PASSWORD ssh -n -o StrictHostKeyChecking=no \
        -o UserKnownHostsFile=/dev/null \
        $USERNAME@$host \
        $SSH_COMMAND 2> /dev/null\
        |  if grep -q $TMUX_SESSION
    then 
        echo "SESSION RUNS!"
    else 
        echo "SESSION DOES NOT RUN"  
    fi
    ((n=n+1))
done < "$file_hosts"
