source conf.sh
#!/bin/bash
echo "running always script 'user_code.sh' "
i=0
while true
do
        echo "running... procnum:" $i
        bash user_code.sh
        echo "done $i, sleeping"
        sleep $PAUSE_TIME
        i=$((i+1))
done
