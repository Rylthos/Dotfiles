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
        ./latex
        ./mako
        ./neovim
        ./nvibrant
        ./packages
        ./photography
        ./pyprland
        ./python
        ./razer
        ./recording
        ./screen_recorder
        ./spotify
        ./spotify_player
        ./tauon
        ./theme
        ./tmux
        ./waybar
        ./wireshark
        ./wlogout
        ./wofi
        ./yazi
    ];

    colorscheme = nix-colors.colorSchemes.catppuccin-macchiato;
}
