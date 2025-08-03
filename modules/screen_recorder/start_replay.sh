#!/bin/sh

pidof -q gpu-screen-recorder && exit 0
video_path="$HOME/Videos/Replays"
mkdir -p "$video_path"

# 60 FPS
# cbr - constant bit rate
# Two audio channels, output and input
notify-send "Start replay"
gpu-screen-recorder -w screen -f 60 -a "output/app-inverse:alsa_playback.spotify_player" -a "microphone/default_input" -a "spotify/app:alsa_playback.spotify_player" -c mkv -bm cbr -q 40000 -r 120 -o "$video_path"
