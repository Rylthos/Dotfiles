{ inputs, pkgs, config, nix-colors, ... }:
{
    home.stateVersion = "24.05";
    imports = [
        nix-colors.homeManagerModules.default

        ./alacritty
        ./direnv
        ./discord
        ./firefox
        ./fish
        ./git
        ./gui_packages
        ./hypridle
        ./hyprland
        ./hyprlock
        ./mako
        ./neovim
        ./packages
        ./pyprland
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
