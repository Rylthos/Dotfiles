{ inputs, ... }: {
  imports = [
    inputs.home-manager.flakeModules.home-manager
    inputs.flake-parts.flakeModules.modules

    inputs.nix-colors.homeManagerModules.default
    ({ ... }: {colorScheme = inputs.nix-colors.colorSchemes.catppuccin-macchiato; })
  ];

  config.systems = [
    "x86_64-linux"
  ];
}
