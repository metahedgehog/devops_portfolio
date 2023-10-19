#!/bin/bash
# This script checks if device is online and if no it runs echo "hi"
# It also saves the device status to a file and notifies if it changes

# Replace <device_ip> with the IP address of the device you want to check
device_ip=192.168.0.139

# Replace <status_file> with the path of the file where you want to save the status
status_file=~/boiler.status

# Ping the device with one packet and store the exit code
ping -c 1 $device_ip > /dev/null 2>&1
exit_code=$?

# If the exit code is 0, it means the device is online
if [ $exit_code -eq 0 ]; then
  device_status="online"
else
  device_status="offline"
fi

# Read the previous status from the file, if any
if [ -f $status_file ]; then
  prev_status=$(cat $status_file)
else
  prev_status=""
fi

if [ "$device_status" != "$prev_status" ] && [ -n "$prev_status" ] && [ "$device_status" = "offline" ]; then
  curl -d "No Electricity! Tun of PC." https://ntfy.sh/pcSGisGsd85Pa2Uj
fi

if [ "$device_status" != "$prev_status" ] && [ -n "$prev_status" ] && [ "$device_status" = "online" ]; then
  curl -d "Electricity back! Enjoy." https://ntfy.sh/pcSGisGsd85Pa2Uj
fi

# Write the current status to the file
echo $device_status > $status_file