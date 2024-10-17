{ pkgs, lib, config, ... }:
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
            okular

            xwaylandvideobridge

            grim
            slurp

            wl-clipboard

            digikam
            darktable

            steam
        ];
    };
}
