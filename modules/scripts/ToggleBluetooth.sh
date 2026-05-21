#!/bin/sh

STATE=$(echo show | bluetoothctl | grep "Powered" | awk '{print $2}')

if [ $STATE == "yes" ]; then
    bluetoothctl power off
    notify-send "Bluetooth off"
else
    bluetoothctl power on
    notify-send "Bluetooth on"
fi

echo $STATE
