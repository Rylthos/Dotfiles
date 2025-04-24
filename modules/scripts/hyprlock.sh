grim -l 0 /tmp/current_screen.png &
wpctl set-mute @DEFAULT_AUDIO_SINK@ 1 &
playerctl --all-players stop &
sudo /run/current-system/sw/bin/pkill evtest
wait &&
hyprlock
