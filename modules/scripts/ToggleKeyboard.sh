#!/bin/sh

PID=$(pidof evtest)

if [[ $1 == "icon" ]]; then
    if [[ $PID == "" ]]; then
        printf '{"alt": "enabled"}'
    else
        printf '{"alt": "disabled"}'
    fi
else
    if [[ $PID == "" ]]; then
        notify-send "Keyboard Turned off"
        sudo /etc/profiles/per-user/aaron/bin/evtest --grab /dev/input/event0 >> /dev/null 2>>/dev/null &
    else
        sudo /run/current-system/sw/bin/pkill evtest
        notify-send "Keyboard Turned on"
    fi
fi
