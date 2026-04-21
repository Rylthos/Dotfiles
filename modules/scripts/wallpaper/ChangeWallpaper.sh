#!/usr/bin/env bash

if [[ $# -gt 0 ]]; then
    swww img "$1" --transition-type any --transition-fps 90 --transition-duration 5 --transition-bezier .42,0,1,1 --resize crop
fi
