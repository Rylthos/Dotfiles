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
        ./lutris
        ./mako
        ./neovim
        ./nvibrant
        ./packages
        ./photography
        ./prismlauncher
        ./pureref
        ./pyprland
        ./python
        ./razer
        ./recording
        ./screen_recorder
        ./spotify
        ./spotify_player
        ./ssh
        ./starship
        ./tauon
        ./theme
        ./tmux
        ./waybar
        ./wireshark
        ./wlogout
        ./wofi
        ./yazi
        ./zsh
    ];

    colorscheme = nix-colors.colorSchemes.catppuccin-macchiato;
}
