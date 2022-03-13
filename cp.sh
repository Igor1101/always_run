#!/bin/sh
USERNAME=$1
PASSWORD=$2
# file_hosts data format:
# X.X.X.X
file_hosts='hosts.txt'
n=1
while read line 
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
    sshpass -p $PASSWORD ssh $USERNAME@$host \
        'cd always_run; ./init.sh'
done < $file_hosts
