#!/bin/bash

config="$HOME/.config"
dotfiles="$config/.dotfiles"

echo $config
echo $dotfiles

# # Linking
ln -sf "$dotfiles/fish" $config
ln -sf "$dotfiles/nvim" $config
