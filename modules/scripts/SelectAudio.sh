#!/usr/bin/env bash

HEIGHT=200
ARGS=(--show dmenu --sort alphabetical -M fuzzy -i --height $HEIGHT)

get_sinks() {
    local -n arr=$1
    IFS=$'\n'
    arr=($(\
        wpctl status | \
        awk "/Sinks:/{flag=1;next}/Sources:/{flag=0}flag" | \
        sed "s/[ ]*│[ ]*//"  | \
        awk 'length($0) > 1' \
    ))
}

get_sources() {
    local -n arr=$1
    IFS=$'\n'
    arr=($(\
        wpctl status | \
        awk "/Sources:/{flag=1;next}/Filters:/{flag=0}flag" | \
        sed "s/[ ]*│[ ]*//"  | \
        awk 'length($0) > 1' \
    ))
}

print_lines() {
    local -n array=$1
    printf "%s\n" ${array[@]}
}


SELECTED=$(echo -en "Sinks\nSources" | wofi "${ARGS[@]}")

if [[ "$SELECTED" == "Sinks" ]]; then
    get_sinks LINES
    NAMES=($(print_lines LINES | sed "s|[\* ]*\([0-9]\+\.\) \(.*\) \[vol: [0-9\. A-Za-z]\+\]|\1 \2|"))

    SELECTED=$(print_lines NAMES | wofi "${ARGS[@]}")

    if [[ "$SELECTED" != "" ]]; then
        CHOSEN=$(echo $SELECTED | sed "s|\([0-9]\+\).*|\1|")
        $(wpctl set-default $CHOSEN)
    fi
elif [ "$SELECTED" == "Sources" ]; then
    get_sources LINES
    NAMES=($(print_lines LINES | sed "s|\*\s\+\([0-9]\+\)\. \(\([A-Za-z0-9\.()]\+\s\)\+\)\s\+\(\[vol: [0-9\.]\+\]\)\?|\1. \2|"))

    SELECTED=$(print_lines NAMES | wofi "${ARGS[@]}")

    if [[ "$SELECTED" != "" ]]; then
        CHOSEN=$(echo $SELECTED | sed "s|\([0-9]\+\).*|\1|")
        $(wpctl set-default $CHOSEN)
    fi
else
    :
fi
