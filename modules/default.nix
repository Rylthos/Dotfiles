{ inputs, pkgs, config, nix-colors, ... }:
{
    home.stateVersion = "24.05";
    imports = [
        nix-colors.homeManagerModules.default

        ./alacritty
        ./direnv
        ./firefox
        ./fish
        ./git
        ./gui_packages
        ./hyprland
        ./mako
        ./neovim
        ./packages
        ./python
        ./spotify_player
        ./theme
        ./tmux
        ./waybar
        ./wlogout
        ./wofi
    ];

    colorscheme = nix-colors.colorSchemes.catppuccin-macchiato;
}
