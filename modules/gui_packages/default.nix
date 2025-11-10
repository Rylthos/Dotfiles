{ pkgs, lib, nixpkgs, config, ... }:
    with lib;
    let cfg = config.modules.gui_packages;
in {
    options.modules.gui_packages = { enable = mkEnableOption "gui_packages"; };
    config = mkIf cfg.enable {
        home.packages = with pkgs; [
            kicad
            freecad
            krita
            arduino-ide
            libreoffice-qt
            vlc
            xournalpp
            blender

            vesktop
            xdg-utils

            kdePackages.okular
            kdePackages.xwaylandvideobridge
            zathura

            grim
            slurp

            wl-clipboard

            steam

            wayfarer

            wineWowPackages.stable

            kdePackages.kate
            gparted

            graphviz
            gephi

            trilium-next-desktop

            moonlight-qt
        ];
    };
}
