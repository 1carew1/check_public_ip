#!/bin/bash

# */15 * * * * /home/pi/script/publicIP.sh > /home/pi/script/checkPublicIp.log 2>&1
DIRECTORY='/home/pi/script'
OUTPUT_FILE="$DIRECTORY/whats_my_ip.txt"
CURRENT_IP_FILE="$DIRECTORY/current_ip_address.txt"
EMAIL_RECEIPIENT='colmcarew2@gmail.com'
CURRENT_IP=$(cat $CURRENT_IP_FILE)
IP_ADDRESS=$(wget http://ipecho.net/plain -O - -q ; echo)
DATE=$(date)

echo "`date` - Adding Public IP to $OUTPUT_FILE"
echo "$DATE - $IP_ADDRESS" >> $OUTPUT_FILE
  if [ "$CURRENT_IP" != "$IP_ADDRESS" ] && ["$IP_ADDRESS" != ""] ; then
           echo "`date` - IP address has changed from $CURRENT_IP to $IP_ADDRESS"
       echo "IP Address has changed to : $IP_ADDRESS" | mail -s "Your public home ip is now : $IP_ADDRESS" - $EMAIL_RECEIPIENT
       echo $IP_ADDRESS > $CURRENT_IP_FILE
  else
            echo "`date` - IP address has not changed"
  fi
