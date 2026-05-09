{ self, inputs, config, ... }: let
  modules = [
    "base"
    "terminal"
    "desktop"
    "gaming"
    "keyboard-keyboard"
    "udev"

    "user-aaron"

    "desktop-art"
    "desktop-cad"
    "desktop-nvibrant"
    "desktop-photography"
    "desktop-pureref"
    "desktop-recording"
    "desktop-screen-recorder"
    "desktop-wireshark"
  ];
  user = "aaron";
in {
  flake.nixosConfigurations.desktop = inputs.nixpkgs.lib.nixosSystem {
    modules = [
      self.modules.nixos.desktop-hardware
      self.modules.nixos.desktop-config
      self.modules.nixos.desktop-modules
      self.modules.nixos.desktop-options
    ];
  };

  flake.modules.nixos.desktop-options = { ... }: {
    configuration.machine.hostname = "desktop";
    configuration.machine.host = "desktop";
    configuration.user = user;
  };

  flake.modules.nixos.desktop-modules = { ... }:
    config.flake.lib.loadNixosAndHM config modules user;
}
