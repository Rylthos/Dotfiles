#!/bin/sh

# nix-shell -p pkg-config cairo ninja gobject-introspection playerctl --run 'waybar >> /home/aaron/.dotfiles/.waybar_log 2>> /home/aaron/.dotfiles/.waybar_log &'
waybar > /home/aaron/.dotfiles/.waybar_log 2> /home/aaron/.dotfiles/.waybar_log &
# nix-shell -p pkg-config cairo ninja gobject-introspection playerctl --run 'source /home/aaron/.dotfiles/modules/waybar/.venv/bin/activate && env GTK_DEBUG=interactive waybar &'
