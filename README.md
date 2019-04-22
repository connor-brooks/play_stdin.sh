# play_stdin.sh
*Stream audio via bash*

This script allows streaming audio between two Linux machines, for example, a laptop and a Raspberry Pi. No audio backends such as Pulseaudio are required, the list of dependencies is very basic.
## Requirements (server)
* ncat (from nmap)
* ffplay
## Requirements (client)
* netcat (any)

## Instructions 
Install sever dependencies, for example, if you're using a Raspberry Pi, SSH into it and run:

`sudo apt-get install ffplay nmap`

Then start the server, by running:

`./play_stdin_server.sh &`

You can now disconnect from the server.

On your client, you can now run:

`cat music.mp3 | ./play_stdin.sh &`

Where `music.mp3` is the song you'd like to play.

To pause from your client:

`./play_stdin.sh TOGGLE`

Or to stop the stream:

`./play_stdin.sh STOP`

## Notes 
* You can easily bind the toggle and stop commands using xbindkeys for a more seamless experience
* It is possible to stream any audio format supported by FFmpeg
* If you are using netcat-traditional or netcat-openbsd on your server you may run into some issues, it is recommended to use ncat from the nmap package
