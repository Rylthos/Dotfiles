#!/bin/sh

HEIGHT=200
ARGS=(--show dmenu --sort alphabetical -M fuzzy -i --height $HEIGHT)

pidof -q gpu-screen-recorder && exit 0
video_path="$HOME/Videos/Replays"
mkdir -p "$video_path"

list_monitors() {
    IFS=$'\n'
    arr=($(hyprctl monitors | grep "Monitor" | sed "s|Monitor \(.*\) (ID [0-9]\+):|\1|"))
    printf "%s\n" ${arr[@]}
}

selected=$(list_monitors | wofi "${ARGS[@]}")

if [[ "$selected" != "" ]]; then
    notify-send "$(printf "Start replay: %s" $selected)"

    # 60 FPS
    # cbr - constant bit rate
    gpu-screen-recorder -w $selected -f 60 -a "app-inverse:alsa_playback.spotify_player|app-inverse:firefox" -a "default_input" -a "app:alsa_playback.spotify_player" -a "app:firefox" -c mkv -bm cbr -q 40000 -r 120 -o "$video_path"
fi
