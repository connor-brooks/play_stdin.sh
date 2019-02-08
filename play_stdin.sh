#!/bin/bash
CONTROLLER_IP=127.0.0.1
CONTROLLER_PORT=1337
CONTROLLER_PASSWORD=PAsswd

echo "Requesting audio server to start..."


echo "HELLO" | netcat -w 1 $CONTROLLER_IP $CONTROLLER_PORT 

PLAYER_PORT=$(echo "NEW" | netcat -w 1 $CONTROLLER_IP $CONTROLLER_PORT)

echo "port is $PLAYER_PORT" 

netcat $CONTROLLER_IP $PLAYER_PORT <&0
# echo "Requesting audio server to stop..."
# echo "stop" | netcat -w 1 192.168.1.154 1993 1> /dev/null
# echo "Done!"
# 

