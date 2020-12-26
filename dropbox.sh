#!/bin/#!/usr/bin/env bash

source ./config.txt

## Reverse SSH tunnel
if [ "$REVSSH_ENABLED" -eq 1 ]; then
     $WORKDIR/revssh/autossh-connect.sh
fi
