#!/bin/sh
# please don`t edit these:
USERNAME=$1
PASSWORD=$2
SSH_COMMAND='cd always_run;bash ./init.sh'
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
        curl --insecure --user "$USERNAME:$PASSWORD" \
             -T $filename  "sftp://$host/home/$USERNAME/always_run/$filename"\
             --ftp-create-dirs
    done
    # run init
    !sshpass -p $PASSWORD ssh -o StrictHostKeyChecking=no \
        -o UserKnownHostsFile=/dev/null \
        $USERNAME@$host \
        $SSH_COMMAND
    ((n=n+1))
done < "$file_hosts"
