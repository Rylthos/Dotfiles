{ self, ... }: let
  filePath = "$NIXOS_MODULES_DIR/features/keyboard/";
in {
  flake.modules.homeManager.keyboard-keyboard = { pkgs, config, ... }: {
    home.packages = with pkgs; [
      qmk
    ];

    home.file."qmk_firmware/keyboards/splitkb/aurora/sofle_v2/keymaps/Rylthos" = if (builtins.pathExists (builtins.toString "/home/aaron/qmk_firmware")) then {
      source = config.lib.file.mkOutOfStoreSymlink "${filePath}/sofle_v2_Rylthos";
      recursive = true;
    } else {
      source = builtins.toFile "empty" "";
    };

    xdg.configFile."qmk/qmk.ini" = {
      source = config.lib.file.mkOutOfStoreSymlink "${filePath}/qmk.ini";
    };
  };
}
