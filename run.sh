#!/bin/sh
echo "running always script 'cp_run.sh' "
i=0
while true
do
        echo "running... procnum:" $i
        bash user_code.sh
        echo "done $i, sleeping"
        sleep 10
        i=$((i+1))
done
