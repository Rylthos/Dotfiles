#!/usr/bin/env bash

if [[ $# < 1 ]]; then
    printf "Invalid usage.\n"
    printf "%s <flake> <args...>\n" $0
else
    nixos-rebuild switch --sudo --flake $NIXOS_CONFIG_DIR/.#$1 --impure ${@:2}
fi
