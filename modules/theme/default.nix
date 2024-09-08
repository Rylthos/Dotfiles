{ pkgs, lib, config, ... }:
with lib;
let cfg = config.modules.theme;
in {
    options.modules.theme = { enable = mkEnableOption "theme"; };
    config = mkIf cfg.enable {
        home = {
            pointerCursor = {
                gtk.enable = true;
                package = pkgs.bibata-cursors;
                name = "Bibata-Modern-Classic";
                size = 13;
            };
        };

        gtk = {
            enable = true;
            theme = {
                package = pkgs.adementary-theme;
                name = "Adementary-dark";
            };
            iconTheme = {
                package = pkgs.libsForQt5.breeze-icons;
                name = "breeze-dark";
            };
        };

        qt = {
            enable = true;
            style = {
                # package = pkgs.adwaita-qt;
                name = "breeze";
            };
        };
    };
}
