#!/usr/bin/env bash

wallpapers=($($NIXOS_SCRIPTS_DIR/ListBackground.sh))
wallpaperDir="$(xdg-user-dir PICTURES)/Wallpapers"

currentBackground=$(swww query | grep -oP -m 1 "image: \K.*")

selectedEntry=$(for a in ${wallpapers[@]}; do echo -en "img:$a:text:$(echo $a | sed -n "s|$wallpaperDir/\(.*\)\..*|\1|gp")\n"; done | wofi --show dmenu -i -I -M fuzzy --parse-search -p "")
selectedBackground=$(echo $selectedEntry | sed -n "s|img:\(.*\):text:.*|\1|gp")

$($NIXOS_SCRIPTS_DIR/ChangeBackground.sh $selectedBackground)
