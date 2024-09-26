#!/bin/sh

nix-shell -p pkg-config cairo ninja gobject-introspection playerctl --run 'source /home/aaron/.dotfiles/modules/waybar/.venv/bin/activate && waybar >> /home/aaron/.dotfiles/waybar.log 2>> /home/aaron/.dotfiles/waybar.log &'
# nix-shell -p pkg-config cairo ninja gobject-introspection playerctl --run 'source /home/aaron/.dotfiles/modules/waybar/.venv/bin/activate && env GTK_DEBUG=interactive waybar &'
