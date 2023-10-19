#!/bin/bash
# Get the user name and IP address of the ssh connection
USER=$PAM_USER
IP=$PAM_RHOST
# Send a notification using ntfy
curl -d "[sever]$USER logged in from $IP" https://ntfy.sh/ncXOfS1MxVqJu3Cq

#Put to: /usr/local/bin/notify-ssh.sh

#Edit /etc/pam.d/sshd: session optional pam_exec.so seteuid /usr/local/bin/notify-ssh.sh