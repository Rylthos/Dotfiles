{ self, config, ... }: let
  modules = [
    "udev-teensy"
    "udev-picotools"
  ];
in {
  flake.modules = self.lib.groupPackages config modules "udev";
}
