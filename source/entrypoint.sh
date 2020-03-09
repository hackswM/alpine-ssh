#!/bin/sh
# Generate SSH Keygen
echo "-> Generating OpenSSH Host Keys ..."
ssh-keygen -A > /startup.log
# Start SSH Daemon
echo "-> Starting OpenSSH Server Daemon ..."
/usr/sbin/sshd
# Finish Starting Container
if [ "$?" = "0" ]; then
    echo "-> Start Success!"
    echo "-> Use username *root* and password *alpine* to login the SSH !"
else
    echo "[X] OpenSSH Start Failure !"
    echo "-> Container will exit with error !"
    exit 1
fi
# Some jobs need to do after Starting OpenSSH Server
echo "-> Still Preparing the container enviroment, but you can now login to the SSH !"
echo "-> Running: apk update ..."
apk update > /startup.log
echo "-> Running: apk upgrade ..."
apk upgrade > /startup.log
# Finish extra jobs
echo "-> Start Finished ! Enjoy your Docker-Linux Container !"
# Hold on the start process to keep container running (Experimental)
tail -f /dev/null
