#!/bin/sh
USERNAME=$1
PASSWORD=$2
# file_hosts data format:
# X.X.X.X
file_hosts='hosts.txt'
n=1
while read line 
do
        echo "linenum(host): $n:$line"
        curl --insecure --user "$USERNAME:$PASSWORD" -T ./cp.sh  "sftp://$line/home/$USERNAME/always_run" --ftp-create-dirs
done < $file_hosts
