{ self, ... }: {
  flake.modules.nixos.base-environment = { ... }: {
    environment = {
        variables = {
            NIXOS_CONFIG_DIR = "$HOME/.dotfiles";
            NIXOS_MODULES_DIR = "$NIXOS_CONFIG_DIR/modules";
            NIXOS_SCRIPTS_DIR = "$NIXOS_MODULES_DIR/scripts";

            MOZ_ENABLE_WAYLAND = "1";
            EDITOR = "nvim";
            QT_QPA_PLATFORM = "wayland;xcb";
            QT_QPA_PLATFORMTHEME = "qt5ct";
            QT_STYLE_OVERRIDE = "kvantum";
        };

        sessionVariables = {
          MOZ_USE_XINPUT2 = "1";
          NIXOS_OZONE_WL = "1";
          WLR_NO_HARDWARE_CURSOR = "1";
          XCURSOR_SIZE = "24";
        };
    };
  };
}
