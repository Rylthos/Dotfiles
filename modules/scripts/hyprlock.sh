grim -o eDP-1 -l 0 /tmp/current_screen.png &
wpctl set-mute @DEFAULT_AUDIO_SINK@ 1 &
wait &&
hyprlock
