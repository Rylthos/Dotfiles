{ pkgs, lib, config, ... }:
    with lib;
    let cfg = config.modules.packages;
in {
    options.modules.packages = { enable = mkEnableOption "packages"; };
    config = mkIf cfg.enable {
        home.packages = with pkgs; [
            feh
            fastfetch
            eza
            btop
            p7zip
            wget
            octave
            ffmpeg
            imhex
            imagemagick
            pandoc

            playerctl

            evtest

            perl

            esptool

            bat
            ripgrep
            fd
            fzf
        ];
    };
}
