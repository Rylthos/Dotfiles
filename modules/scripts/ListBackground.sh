#!/usr/bin/env bash

wallpapersDir="$(xdg-user-dir PICTURES)/Wallpapers"

wallpapers=("$wallpapersDir"/*.png)
wallpapers+=("$wallpapersDir"/*/*.png)
wallpapers+=("$wallpapersDir"/*.jpg)
wallpapers+=("$wallpapersDir"/*/*.jpg)

printf "${wallpapers[*]}"
