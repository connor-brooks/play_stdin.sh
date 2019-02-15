#!/bin/bash
CONTROLLER_IP=127.0.0.1
CONTROLLER_PORT=1337
#CONTROLLER_PASSWORD=PAsswd # Not used

echo "Requesting audio server to start..."

# Check the server is up
echo "HELLO" | netcat -w 1 $CONTROLLER_IP $CONTROLLER_PORT 

# Grab the audio stream port from the server
PLAYER_PORT=$(echo "NEW" | netcat -w 1 $CONTROLLER_IP $CONTROLLER_PORT)
echo "port is $PLAYER_PORT" 

# pipe arg0 (The cat'd audio file) to the audio stream server
netcat $CONTROLLER_IP $PLAYER_PORT <&0

# Finishing up, ignore
# echo "Requesting audio server to stop..."
# echo "stop" | netcat -w 1 192.168.1.154 1993 1> /dev/null
# echo "Done!"
# 

