#!/usr/bin/env bash

WALLPAPERS=($($NIXOS_SCRIPTS_DIR/wallpaper/ListWallpapers.sh))
WALLPAPER_DIR="$(xdg-user-dir PICTURES)/Wallpapers"

CACHE_DIR="$HOME/.cache/WallpaperPicker"
THUMBNAIL_WIDTH="250"
THUMBNAIL_HEIGHT="141"

mkdir -p $CACHE_DIR

get_filename() {
    local input="$1"
    echo $input | sed -n "s|$WALLPAPER_DIR/\(.*\)|\1|gp"
}

generate_thumbnail() {
    local input="$1"
    local output="$2"
    magick "$input" -thumbnail "${THUMBNAIL_WIDTH}x${THUMBNAIL_HEIGHT}^" -gravity center -extent "${THUMBNAIL_WIDTH}x${THUMBNAIL_HEIGHT}" "$output"
}

generate_menu() {
    for img in ${WALLPAPERS[@]}; do
        thumbnail="$CACHE_DIR/$(basename "${img%.*}").png"

        if [[ ! -f "$thumbnail" ]] || [[ "$img" -nt "$thumbnail" ]]; then
            generate_thumbnail "$img" "$thumbnail"
        fi

        echo -en "$(get_filename $img):img:$thumbnail\n"
    done
}

selected=$(generate_menu | wofi --show dmenu \
    --cache-file /dev/null \
    --define "image-size=${THUMBNAIL_WIDTH}x${THUMBNAIL_HEIGHT}" \
    --columns 3 \
    --allow-images \
    --insensitive \
    --sort-order=default \
    --prompt "Select Wallpaper" \
    --matching fuzzy \
    --style $NIXOS_SCRIPTS_DIR/wallpaper/wofi/Picker.css \
    --conf $NIXOS_SCRIPTS_DIR/wallpaper/wofi/Picker.conf
  )


if [ -n "$selected" ]; then
    image_path="$(echo $selected | sed -n "s|\(.*\):img:.*|\1|gp")"

    $($NIXOS_SCRIPTS_DIR/wallpaper/ChangeWallpaper.sh $WALLPAPER_DIR/$image_path)

    notify-send "Set wallpaper to $(basename $image_path)"
fi
