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
    "desktop-discord"
    "desktop-nvibrant"
    "desktop-photography"
    "desktop-pureref"
    "desktop-recording"
    "desktop-screen-recorder"
    "desktop-wireshark"

    "laptop-options"
  ];
  user = "aaron";
in {
  flake.nixosConfigurations.laptop = inputs.nixpkgs.lib.nixosSystem {
    modules = [
      self.modules.nixos.laptop-hardware
      self.modules.nixos.laptop-config
      self.modules.nixos.laptop-modules
    ];
  };

  flake.modules.nixos.laptop-options = { ... }: {
    configuration.machine.hostname = "laptop";
    configuration.machine.host = "laptop";
    configuration.user = user;
  };

  flake.modules.homeManager.laptop-options = { ... }: {
    programs.zsh.shellAliases = {
      work = "cd $HOME/Documents/Cambridge/PartII/";
      coding = "cd $HOME/Documents/Coding/";
    };
  };

  flake.modules.nixos.laptop-modules = { ... }:
    config.flake.lib.loadNixosAndHM config modules user;
}
