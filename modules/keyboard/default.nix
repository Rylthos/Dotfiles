{ pkgs, lib, config, ... }:
    with lib;
    let cfg = config.modules.keyboard;
in {
    options.modules.keyboard = { enable = mkEnableOption "keyboard"; };
    config = mkIf cfg.enable {
        home.packages = with pkgs; [
            qmk
        ];

        home.file."qmk_firmware/keyboards/splitkb/aurora/sofle_v2/keymaps/Rylthos" = {
            source = ./sofle_v2_Rylthos;
            recursive = true;
        };

        xdg.configFile."qmk/qmk.ini" = {
            source = ./qmk.ini;
        };
    };
}
