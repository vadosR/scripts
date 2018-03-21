#!/bin/bash

df -h | grep home

echo "Clearing /home from cpmove archives ..."
rm -f /home/cpmove-*.tar.gz

echo -n > /root/path_errorlog.txt
echo -n > /root/users_log100.txt
echo "Finding error log files greater than 100M . . ."
find /home -type f -name "*error_log*" -size +100M -exec ls -lth {} \; >> /root/path_errorlog.txt

echo "Clearing finded log files . . ."
for i in `cat /root/path_errorlog.txt | awk '{print $9}'`
do
echo > "$i"
done

echo "Users whose logs greater 100M:" >> /root/users_log100.txt
for j in `cat /root/path_errorlog.txt | awk '{print $9}' | cut -d / -f3 | grep -v virtfs | sort | uniq`
do
echo "$j" >> /root/users_log100.txt
done

rm -f /root/path_errorlog.txt

echo "Clearing default mailbox . . ."
######################
for curmail in `cat /etc/trueuserdomains |awk '{print $2}' | sort| uniq`;do
	find /home/$curmail/mail/cur/ -type f
done | xargs rm -f
######################
for newmail in `cat /etc/trueuserdomains |awk '{print $2}' | sort| uniq`;do
	find /home/$newmail/mail/new/ -type f
done | xargs rm -f
######################
echo 'Directory /home were cleared. Users with logs greater 100M you can find in /root/users_log100.txt'
df -h | grep home
