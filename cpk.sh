#!/bin/bash
source conf.sh
# please don`t edit these:
USERNAME=$1
KEY_PATH=$2
SSH_COMMAND='cd always_run;bash ./init.sh'
USED_KEY_PATH=$KEY_PATH
if [ -z "$KEY_PATH" ]
then
    echo "KEY_PATH is empty, trying DEFAULT_KEY_PATH"
    if [ -z "$DEFAULT_KEY_PATH" ]
    then
        echo "ERROR KEY_PATH and DEFAULT_KEY_PATH are empty"
        exit 1
    else
        USED_KEY_PATH=$DEFAULT_KEY_PATH
    fi
fi
echo "USING KEY:" $USED_KEY_PATH
# file_hosts data format:
# X.X.X.X
file_hosts='hosts.txt'
n=1
while IFS= read -r  line     
do
    host=$line
    echo "linenum(host): $n:$host"
    # copy all the files
    for filename in $(ls)
    do 
        curl --insecure --user "$USERNAME:" \
             --key $USED_KEY_PATH \
             -T $filename  "sftp://$host/home/$USERNAME/always_run/$filename"\
             --ftp-create-dirs
    done
    # run init
    ssh -i $USED_KEY_PATH -n -o StrictHostKeyChecking=no \
        -o UserKnownHostsFile=/dev/null \
        $USERNAME@$host \
        $SSH_COMMAND
    ((n=n+1))
done < "$file_hosts"
