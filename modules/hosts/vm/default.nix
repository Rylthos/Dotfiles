{ self, inputs, config, ... }: let
  modules = [
    "base"
    "terminal-neovim"
    "terminal-zsh"
    "terminal-starship"
    "terminal-tmux"
  ];
in {
  flake.nixosConfigurations.vm = inputs.nixpkgs.lib.nixosSystem {
    modules = [
      self.modules.nixos.vm-config
      self.modules.nixos.vm-modules
      self.modules.nixos.vm-options
    ];
  };

  flake.modules.nixos.vm-options = { ... }: {
    configuration.machine.hostname = "vm";
    configuration.machine.host = "vm";
  };

  flake.modules.nixos.vm-modules = { ... }:
    config.flake.lib.loadNixosAndHM config modules "vm";
}
