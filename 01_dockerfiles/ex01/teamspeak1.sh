#!/bin/sh
### BeginN INIT INFO
# Provides: teamspeak
# Required-Start: $local_fs $network
# Required-Stop: $local_fs $network
# Default-Start: 2 3 4 5
# Default-Stop: 0 1 6
# Description: Teamspeak 3 Server
### END INIT INFO

USER="root"
DIR="/home/teamspeak/teamspeak3-server_linux-amd64"
###### Teamspeak 3 server start/stop script ######
case "$1" in
start)
su $USER -c "$DIR/ts3server_minimal_runscript.sh start"
;;
stop)
su $USER -c "$DIR/ts3server_minimal_runscript.sh stop"
;;
restart)
su $USER -c "$DIR/ts3server_minimal_runscript.sh restart"
;;
status)
su $USER -c "$DIR/ts3server_minimal_runscript.sh status"
;;
*)
echo "Usage: " >&2
exit 1
;;
esac
exit 0
