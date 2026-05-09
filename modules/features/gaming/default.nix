{ self, config, ... }: let
  modules = [
    "gaming-lutris"
    "gaming-prismlauncher"
    "gaming-steam"
  ];
in {
  flake.modules = self.lib.groupPackages config modules "gaming";
}
