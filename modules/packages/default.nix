{ pkgs, lib, config, ... }:
    with lib;
    let cfg = config.modules.packages;
in {
    options.modules.packages = { enable = mkEnableOption "packages"; };
    config = mkIf cfg.enable {
        home.packages = with pkgs; [
            feh
            fastfetch
            btop
            p7zip
            wget
            octave
            ffmpeg
            imhex
            imagemagick
            pandoc

            playerctl

            texlab
            texlive.combined.scheme-full

            evtest
        ];
    };
}
