{ self, config, ... }: let
  modules = [
    "desktop-alacritty"
    "desktop-firefox"
    "desktop-hyprland"
    "desktop-mako"
    "desktop-packages"
    "desktop-theme"
    "desktop-thunar"
    "desktop-tuigreet"
    "desktop-waybar"
    "desktop-wlogout"
    "desktop-wofi"
  ];
in {
  flake.modules = self.lib.groupPackages config modules "desktop";
}
