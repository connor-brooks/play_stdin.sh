#!/bin/bash
CONTROLLER_PORT=1337
AUDIO_SERVER_PLAYER="ffplay -nodisp -i -"
CONTROLLER_PIPE_NAME=play_stdin_server
CONTROLLER_PIPE_FILE=/tmp/$CONTROLLER_PIPE_NAME
AUDIO_SERVER_IS_RUNNING=0
AUDIO_SERVER_IS_PAUSED=0
AUDIO_SERVER_PID=0

###################
# Server commands #
###################
# EXIT, kill the whole server
server_exit (){
  echo "GOODBYE!" > $CONTROLLER_PIPE_FILE;
  rm $CONTROLLER_PIPE_FILE
  kill -- -$$;
}

server_audio_toggle () {
  if [[ $AUDIO_SERVER_IS_PAUSED -eq 0 ]]
  then
    kill -STOP $AUDIO_SERVER_PID
    AUDIO_SERVER_IS_PAUSED=1
  else
    kill -CONT $AUDIO_SERVER_PID
    AUDIO_SERVER_IS_PAUSED=0
  fi
}

server_audio_stop () {
  AUDIO_SERVER_IS_RUNNING=0
  kill $AUDIO_SERVER_PID
}

# HELLO - for testing connection, ensuring an audio server can start
server_hello () {
  echo "HELLO" > $CONTROLLER_PIPE_FILE;
}

# NEW, create audio server randomized port and send the port
server_new_stream () {
  if [[ $AUDIO_SERVER_IS_RUNNING -eq 0 ]]
  then
    PORT=$(( (RANDOM % 3000 ) + 1030 ))
    #echo "Starting new audio server on port $PORT"
    ncat -lp $PORT | $AUDIO_SERVER_PLAYER &

    AUDIO_SERVER_PID=$!
    AUDIO_SERVER_IS_RUNNING=1

    echo $PORT > $CONTROLLER_PIPE_FILE;
  fi
}

# respond to commands from client
command_respond () {
  case "$1" in
    "HELLO") server_hello
      ;;
    "BYE") server_exit
      ;;
    "NEW") server_new_stream
      ;;
    "TOGGLE") server_audio_toggle
      ;;
    "STOP") server_audio_stop
      ;;
  esac
}

# Create the pipe
setup_server_fifo () {
  mkfifo $1
  return
}

# Create the pipe for commands
setup_server_fifo $CONTROLLER_PIPE_FILE

# Main loop of server
# constantly pipe fifo into netcat
# constantly read netcat resp and execute related command
# Controller pipe is for messages to clients
while true;
do cat $CONTROLLER_PIPE_FILE;
done |
ncat -l -k -p $CONTROLLER_PORT |
while read line
do
  command_respond $line
done
