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
  flake.nixosConfigurations.laptop = inputs.nixpkgs.lib.nixosSystem {
    modules = [
      self.modules.nixos.laptop-hardware
      self.modules.nixos.laptop-config
      self.modules.nixos.laptop-modules
      self.modules.nixos.laptop-options
    ];
  };

  flake.modules.nixos.laptop-options = { ... }: {
    configuration.machine.hostname = "laptop";
    configuration.machine.host = "laptop";
    configuration.user = user;
  };

  flake.modules.nixos.laptop-modules = { ... }:
    config.flake.lib.loadNixosAndHM config modules user;
}
