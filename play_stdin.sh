#!/bin/bash
CONTROLLER_IP=127.0.0.1
CONTROLLER_PORT=1337
#CONTROLLER_PASSWORD=PAsswd # Not used

function print_usage () {
  echo "usage: cat music.mp3 | $0 &"
  echo "usage: or"
  echo "usage: $0 command"
}

# Check the server is up, exit if not
if [[ "$(echo "HELLO" | netcat -w 1 $CONTROLLER_IP $CONTROLLER_PORT)" != "HELLO" ]]
then
  echo "Server not found, exiting!";
  exit;
fi

# Send command to server 
if [[ "$#" -eq 1 ]]
then
  echo $1 | netcat -w 1 $CONTROLLER_IP $CONTROLLER_PORT;
  exit
fi

# If there are no commands or no piped audio
if [ -t 0 ]
then
  print_usage
  exit
fi

# Grab the audio stream port from the server
PLAYER_PORT=$(echo "NEW" | netcat -w 1 $CONTROLLER_IP $CONTROLLER_PORT)
echo "Playing, you can kill this process now!"
# pipe arg0 (The cat'd audio file) to the audio stream server
(netcat $CONTROLLER_IP $PLAYER_PORT <&0)
exit

