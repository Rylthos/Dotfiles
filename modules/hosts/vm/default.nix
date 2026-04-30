{ self, inputs, config, ... }: let
  modules = [
    "base"
  ];
in {
  flake.nixosConfigurations.vm = inputs.nixpkgs.lib.nixosSystem {
    modules = [
      self.modules.nixos.vm-config
      self.modules.nixos.vm-modules
    ];
  };

  flake.modules.nixos.vm-modules = { ... }:
    config.flake.lib.loadNixosAndHM config modules "vm";
}
