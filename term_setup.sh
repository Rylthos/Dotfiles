#!/bin/bash

config="$HOME/.config"
dotfiles="$config/.dotfiles"

echo $config
echo $dotfiles

# # Linking
ln -sf "$dotfiles/kitty" $config
ln -sf "$dotfiles/awesome" $config
ln -sf "$dotfiles/fish" $config
ln -sf "$dotfiles/nvim" $config
ln -sf "$dotfiles/picom" $config
