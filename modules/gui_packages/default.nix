{ pkgs, lib, nixpkgs, config, ... }:
    with lib;
    let cfg = config.modules.gui_packages;
in {
    options.modules.gui_packages = { enable = mkEnableOption "gui_packages"; };
    config = mkIf cfg.enable {
        home.packages = with pkgs; [
            kicad-unstable
            freecad
            krita
            inkscape
            arduino-ide
            libreoffice-qt
            vlc
            xournalpp
            blender

            xdg-utils

            kdePackages.okular
            zathura

            grim
            slurp

            wl-clipboard

            steam

            wayfarer

            # wineWow64Packages.waylandFull

            kdePackages.kate
            gparted

            graphviz
            gephi

            trilium-next-desktop

            qpwgraph

            moonlight-qt

            kdePackages.ark

            gimp
        ];
    };
}
