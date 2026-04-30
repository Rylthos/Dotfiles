{ self, ... }: {
  flake.modules.nixos.base-environment = { ... }: {
    environment = {
        variables = {
            NIXOS_CONFIG_DIR = "$HOME/.dotfiles";
            NIXOS_DEV_DIR = "$NIXOS_CONFIG_DIR/dev";
            NIXOS_MODULES_DIR = "$NIXOS_CONFIG_DIR/modules";
            NIXOS_SCRIPTS_DIR = "$NIXOS_MODULES_DIR/scripts";

            # MOZ_ENABLE_WAYLAND = "1";
            # EDITOR = "nvim";
            # QT_QPA_PLATFORM = "wayland;xcb";
            # QT_QPA_PLATFORMTHEME = "qt5ct";
            # QT_STYLE_OVERRIDE = "kvantum";
        };
    };
  };
}
