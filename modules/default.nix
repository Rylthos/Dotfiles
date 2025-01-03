{ inputs, pkgs, config, nixpkgs, nix-colors, ... }:
{
    home.stateVersion = "24.05";
    imports = [
        nix-colors.homeManagerModules.default

        ./alacritty
        ./dev_packages
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
        ./spotify
        ./spotify_player
        ./theme
        ./tmux
        ./waybar
        ./wlogout
        ./wofi
    ];

    colorscheme = nix-colors.colorSchemes.catppuccin-macchiato;
}
