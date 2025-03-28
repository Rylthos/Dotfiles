{ pkgs, lib, config, ... }:
    with lib;
    let cfg = config.modules.keyboard;
in {
    options.modules.keyboard = { enable = mkEnableOption "keyboard"; };
    config = mkIf cfg.enable {
        home.packages = with pkgs; [
            qmk
        ];

        home.file."qmk_firmware/keyboards/splitkb/aurora/sofle_v2/keymaps/Rylthos" = if (builtins.pathExists (builtins.toString "/home/aaron/qmk_firmware")) then {
            source = config.lib.file.mkOutOfStoreSymlink "/home/aaron/.dotfiles/modules/keyboard/sofle_v2_Rylthos";
            recursive = true;
        } else { };

        xdg.configFile."qmk/qmk.ini" = {
            source = config.lib.file.mkOutOfStoreSymlink "/home/aaron/.dotfiles/modules/keyboard/qmk.ini";
        };
    };
}
