#!/bin/sh

pidof -q gpu-screen-recorder && exit 0
video_path="$HOME/Videos/Replays"
mkdir -p "$video_path"

# 60 FPS
# cbr - constant bit rate
notify-send "Start replay"
gpu-screen-recorder -w portal -f 60 -a "app-inverse:alsa_playback.spotify_player|app-inverse:firefox" -a "default_input" -a "app:alsa_playback.spotify_player" -a "app:firefox" -c mkv -bm cbr -q 40000 -r 120 -o "$video_path"
