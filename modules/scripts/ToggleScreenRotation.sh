#!/bin/sh

STATUS=$(hyprctl monitors eDP-1 | grep transform | awk '{print $2}')

MONITOR_MSG="hyprctl keyword monitor eDP-1,2880x1800@90,0x0,%.1f,transform,%d"
TOUCHSCREEN_MSG="hyprctl keyword device[elan9008:00-04f3:2e36]:transform %d"

if [[ $1 == "icon" ]]; then
    if [[ $STATUS == "0" ]]; then # NORMAL
        printf '{"alt": "normal"}'
    else
        printf '{"alt": "rotated"}'
    fi
else
    if [[ $STATUS == "0" ]]; then
        notify-send "Screen Rotated"
        $(printf "$MONITOR_MSG" 1.5 1)
        $(printf "$TOUCHSCREEN_MSG" 1)
    else
        notify-send "Screen unrotated"
        $(printf "$MONITOR_MSG" 1.8 0)
        $(printf "$TOUCHSCREEN_MSG" 0)
    fi
fi
