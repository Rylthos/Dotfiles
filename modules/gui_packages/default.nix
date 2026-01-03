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
            inkscape
            arduino-ide
            libreoffice-qt
            vlc
            xournalpp
            blender

            vesktop
            xdg-utils

            kdePackages.okular
            zathura

            grim
            slurp

            wl-clipboard

            steam

            wayfarer

            wineWowPackages.waylandFull

            kdePackages.kate
            gparted

            graphviz
            gephi

            trilium-next-desktop

            qpwgraph

            moonlight-qt
        ];
    };
}
