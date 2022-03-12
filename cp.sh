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
        for filename in $(ls)
        do 
            curl --insecure --user "$USERNAME:$PASSWORD" -T $filename  "sftp://$line/home/$USERNAME/always_run/$filename" --ftp-create-dirs
        done
done < $file_hosts
