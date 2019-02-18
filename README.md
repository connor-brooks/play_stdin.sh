# play_stdin.sh
*Stream audio via bash*
**NOT CURRENTLY FIT FOR HUMAN CONSUMPTION**

This script allows streaming audio between two Linux machines, for example, a laptop and a Raspberry Pi. No audio backends such as Pulseaudio are required, the list of dependencies is very basic.
## Requirements (server)
* ncat (from nmap)
* ffplay
## Requirements (client)
* netcat (any)

## Instructions 
On your server:

`./play_stdin_server.sh &`

On your client, run:

`cat music.mp3 | ./play_stdin.sh &`

To pause from your client:

`./play_stdin.sh TOGGLE`

Or to stop the stream:

`./play_stdin.sh STOP`

If you are using netcat-traditional or netcat-openbsd on your server you may run into some issues, it is recommended to use ncat from the nmap package
