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
        $NIXOS_SCRIPTS_DIR/screenRecorder/start_replay.sh &
    else
        $NIXOS_SCRIPTS_DIR/screenRecorder/stop_replay.sh
    fi
fi
