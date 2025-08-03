#!/bin/sh

PID=$(pidof gpu-screen-recorder)

if [[ $1 == "icon" ]]; then
    if [[ $PID == "" ]]; then
        printf '{"alt": "disabled"}'
    else
        printf '{"alt": "enabled"}'
    fi
else
    if [[ $PID == "" ]]; then
        $NIXOS_MODULES_DIR/screen_recorder/start_replay.sh &
    else
        $NIXOS_MODULES_DIR/screen_recorder/stop_replay.sh
    fi
fi
