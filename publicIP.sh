#!/bin/bash

# */15 * * * * /home/colm/scripts/check_public_ip/publicIP.sh > /home/colm/scripts/check_public_ip/checkPublicIp.log 2>&1
DIRECTORY='/home/colm/scripts/check_public_ip'
OUTPUT_FILE="$DIRECTORY/whats_my_ip.txt"
CURRENT_IP_FILE="$DIRECTORY/current_ip_address.txt"
EMAIL_RECEIPIENT='colmcarew2@gmail.com'

# Create Needed Files if not present
if [ ! -f $OUTPUT_FILE ]; then
	echo "Created : $OUTPUT_FILE"
    touch $OUTPUT_FILE
fi

if [ ! -f $CURRENT_IP_FILE ]; then
	echo "Created : $CURRENT_IP_FILE"
    touch $CURRENT_IP_FILE
fi

CURRENT_IP=$(cat $CURRENT_IP_FILE)
#IP_ADDRESS=$(wget http://ipecho.net/plain -O - -q ; echo)
IP_ADDRESS=$(dig TXT +short o-o.myaddr.l.google.com @ns1.google.com | awk -F'"' '{ print $2}')
DATE=$(date)

echo "`date` - Adding Public IP to $OUTPUT_FILE"
echo "$DATE - $IP_ADDRESS" >> $OUTPUT_FILE
  if [ "$CURRENT_IP" != "$IP_ADDRESS" ] && [ "" !=  "$IP_ADDRESS" ] ; then
       echo "`date` - IP address has changed from $CURRENT_IP to $IP_ADDRESS"
       echo "IP Address has changed to : $IP_ADDRESS" | mail -s "Your public home ip is now : $IP_ADDRESS" $EMAIL_RECEIPIENT
       echo $IP_ADDRESS > $CURRENT_IP_FILE
  else
            echo "`date` - IP address has not changed"
  fi
