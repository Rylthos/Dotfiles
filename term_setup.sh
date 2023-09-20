#!/bin/bash

config="$HOME/.config"
dotfiles="$config/.dotfiles"

echo $config
echo $dotfiles

# # Linking
ln -sf "$dotfiles/fish"  $config
ln -sf "$dotfiles/nvim"  $config
ln -sf "$dotfiles/kitty" $config
ln -sf "$dotfiles/tmux"  $config

mkdir -p ~/.tmux/plugins
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
