#!/bin/sh

killall -SIGINT gpu-screen-recorder &&
    notify-send "Stopped replay"
