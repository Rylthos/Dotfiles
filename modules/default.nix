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
        ./keyboard
        ./mako
        ./neovim
        ./packages
        ./photography
        ./pyprland
        ./python
        ./recording
        ./spotify
        ./spotify_player
        ./theme
        ./tmux
        ./waybar
        ./wireshark
        ./wlogout
        ./wofi
    ];

    colorscheme = nix-colors.colorSchemes.catppuccin-macchiato;
}
