#!/usr/bin/env bash

if [[ -f /tmp/BackgroundLoop.pid ]]; then
    PID=$(cat /tmp/BackgroundLoop.pid)
    if kill -0 $PID 2>/dev/null; then
        notify-send "Disabling background loop"
        kill $PID
        rm /tmp/BackgroundLoop.pid
    fi
else
    notify-send "Enabling background loop"
    $NIXOS_SCRIPTS_DIR/wallpaper/RandomWallpaperLoop.sh &
    echo $! > /tmp/BackgroundLoop.pid
fi
