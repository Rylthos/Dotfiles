{ self, inputs, lib, config, ... }: let
    colourScheme = config.colorScheme;
in {
  flake.modules.homeManager.desktop-quickshell = { pkgs, config, osConfig, ... }: let
    currentPath = "${osConfig.configuration.dotfilesPath}/modules/features/desktop/quickshell/";
  in {
    programs.quickshell = {
      enable = true;
      systemd.enable = false;
    };

    xdg.configFile."quickshell/shell.qml" = {
      source =  config.lib.file.mkOutOfStoreSymlink "${currentPath}/quickshell/shell.qml";
    };

    xdg.configFile."quickshell/Configuration/" = {
      source =  config.lib.file.mkOutOfStoreSymlink "${currentPath}/quickshell/Configuration/";
      recursive = true;
    };

    xdg.configFile."quickshell/Nix/qmldir".text = ''
      module Nix
      singleton Colourscheme 1.0 Colourscheme.qml
    '';

    xdg.configFile."quickshell/Nix/Colourscheme.qml".text = ''
      pragma Singleton

      import Quickshell
      import QtQuick

      Singleton {
        id: root

        readonly property color base:      "#${colourScheme.palette.base00}"
        readonly property color mantle:    "#${colourScheme.palette.base01}"
        readonly property color surface0:  "#${colourScheme.palette.base02}"
        readonly property color surface1:  "#${colourScheme.palette.base03}"
        readonly property color surface2:  "#${colourScheme.palette.base04}"
        readonly property color text:      "#${colourScheme.palette.base05}"
        readonly property color rosewater: "#${colourScheme.palette.base06}"
        readonly property color lavender:  "#${colourScheme.palette.base07}"
        readonly property color red:       "#${colourScheme.palette.base08}"
        readonly property color peach:     "#${colourScheme.palette.base09}"
        readonly property color yellow:    "#${colourScheme.palette.base0A}"
        readonly property color green:     "#${colourScheme.palette.base0B}"
        readonly property color teal:      "#${colourScheme.palette.base0C}"
        readonly property color blue:      "#${colourScheme.palette.base0D}"
        readonly property color mauve:     "#${colourScheme.palette.base0E}"
        readonly property color flamingo:  "#${colourScheme.palette.base0F}"
      }
    '';
  };
}
