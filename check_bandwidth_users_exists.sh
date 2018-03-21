#!/bin/bash

for i in `ls -lt | grep '.sqlite' | awk '{print $9}' |grep -v 'check_bandwidth_users_exists.sh' | cut -d . -f1 | sort | uniq`
do
a=`grep "^$i[:]" /etc/trueuserowners | awk -F: '{print $1}'`

if [ "$i" != "$a" ]
then
echo "$i"
fi
done
