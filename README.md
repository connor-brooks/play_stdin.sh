# play_stdin.sh
*Stream audio via bash*

This script allows streaming audio between two Linux machines, for example, a laptop and a Raspberry Pi. No audio backends such as Pulseaudio are required, the list of dependencies is very basic.
## Requirements (server)
* ncat (from nmap)
* ffplay
## Requirements (client)
* netcat (any)

## Instructions 
### Server
#### Get the script
SSH into your server, and download the scripts via git:

`git clone https://github.com/connor-brooks/play_stdin.sh.git`

#### Install dependancies
If you're using a Raspberry Pi:

`sudo apt-get install ffplay nmap`

#### Configure (optional)
With the text editor of you choice, edit line 2 of `play_stdin_server.sh` and change the `CONTROLLER_PORT` variable to whatever port you want, for example run:

`nano play_stdin_server.sh`

Change the port number, and save.

#### Run the server
To start the server, run the following command:
`./play_stdin_server.sh &`

You can now disconnect from the Raspberry Pi, but before you do, make sure to take note of your servers IP address, buy running the following:

`sudo ifconfig` 

Generally your ip address will be in the format of `192.168.xxx.xxx`


### Client
#### Get the script
`git clone https://github.com/connor-brooks/play_stdin.sh.git`

#### Configure:
Using the text editor of your choice, edit line 2 and 3 of `play_stdin.sh` to match the port and IP of your server. 

#### Play some music
`cat music.mp3 | ./play_stdin.sh &`

Where `music.mp3` is the song you'd like to play.

#### Play and pause

To pause from your client:

`./play_stdin.sh TOGGLE`

Or to stop the stream:

`./play_stdin.sh STOP`

## Notes 
* You can easily bind the toggle and stop commands using xbindkeys for a more seamless experience
* It is possible to stream any audio format supported by FFmpeg
* If you are using netcat-traditional or netcat-openbsd on your server you may run into some issues, it is recommended to use ncat from the nmap package
