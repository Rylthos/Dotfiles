{ pkgs, lib, config, ... }:
    with lib;
    let cfg = config.modules.packages;

    pkgs_imhex = import (builtins.fetchGit {
        name = "imhex_old_revision";
        url = "https://github.com/NixOS/nixpkgs/";
        ref = "refs/heads/nixpkgs-unstable";
        rev = "e6f23dc08d3624daab7094b701aa3954923c6bbb";
        }) {};

    imhex_1_37_4 = pkgs_imhex.imhex;

in {
    options.modules.packages = { enable = mkEnableOption "packages"; };
    config = mkIf cfg.enable {
        home.packages = with pkgs; [
            feh
            imv

            fastfetch
            btop
            p7zip
            wget
            octave
            ffmpeg

            imhex_1_37_4

            imagemagick
            pandoc

            playerctl

            evtest

            perl

            # Improvements over defaults
            eza # ls
            bat # cat
            ripgrep # grep
            fd # find
            fzf # fuzzy find
            dua # du

            mosh
        ];
    };
}
