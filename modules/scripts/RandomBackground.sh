#!/bin/sh

wallpapersDir="$HOME/Pictures/Wallpapers"
backgroundQueue="$HOME/.dotfiles/scripts/.backgroundQueue"

selectedWallpaper=""
currentBackground=$(swww query | grep -oP "image: \K.*")

# Load in all wallpapers
load_wallpapers() {
    wallpapers=("$wallpapersDir"/*.png)
    wallpapers+=("$wallpapersDir"/SimonStalenhag/*.jpg)
    wallpapers+=("$wallpapersDir"/Kobsel/*.png)
    wallpapers+=("$wallpapersDir"/JWST/*.png)
    wallpapers+=("$wallpapersDir"/Own/*.jpg)
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
echo ${wallpapers[*]} > "$HOME/.dotfiles/scripts/.backgroundQueue"

swww img "$selectedWallpaper" --transition-type any --transition-fps 90 --transition-duration 5 --transition-bezier .42,0,1,1 --resize crop
# swww img "$selectedWallpaper" --transition-type simple --transition-fps 90 --transition-duration 2 --transition-bezier .42,0,.58,1
