#!/bin/sh

backgroundQueue="$NIXOS_SCRIPTS_DIR/.backgroundQueue"

selectedWallpaper=""

# Load in all wallpapers
load_wallpapers() {
    wallpapers=($($NIXOS_SCRIPTS_DIR/ListBackground.sh))
}

# If the file exists then load in what is contained in that file
if [ -e $backgroundQueue ]; then
    IFS=' ' read -r -a wallpapers <<< $(cat $backgroundQueue)

    # If the file contains no elements then load in all the wallpapers
    if [ "${#wallpapers[@]}" = 0 ]; then
        load_wallpapers
    fi
else
    # File doesn't exist so just load the file
    load_wallpapers
fi

# Get a random wallpaper out of the list
wallpaperIndex=$((RANDOM % ${#wallpapers[@]}))
selectedWallpaper=${wallpapers[$wallpaperIndex]}

# Remove that wallpaper from the list
wallpapers=("${wallpapers[@]:0:$wallpaperIndex}" "${wallpapers[@]:$wallpaperIndex+1}")

# Save the new list
echo ${wallpapers[*]} > ${backgroundQueue}

$($NIXOS_SCRIPTS_DIR/ChangeBackground.sh $selectedWallpaper)
