#!/bin/bash

source /opt/dropbox/config.txt

read -p "Are you sure you wanna clear the logs in $LOGDIR? (y/n) > " usure

if [ $usure=="y" ]; then
	echo "clearing logs in /opt/dropbox/logs/ ..."
	for line in `ls $LOGDIR/*.log`;do
		#if [ $line == *.log ]; then
			echo "clearing $line"
			echo '' > $line
		#fi
	done
	echo "Logs cleared."
fi
