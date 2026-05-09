{ self, config, ... }: let
  modules = [
    "desktop-hypridle"
    "desktop-hyprland-standalone"
    "desktop-hyprlock"
    "desktop-pyprland"
  ];
in {
  flake.modules = self.lib.groupPackages config modules "desktop-hyprland";
}
