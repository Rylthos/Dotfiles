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
    # "desktop-nvibrant"
    "desktop-photography"
    "desktop-protonvpn"
    "desktop-recording"
    "desktop-screen-recorder"
    "desktop-wireshark"

    "desktop-unity"

    "desktop-options"
  ];
  user = "aaron";
in {
  flake.nixosConfigurations.desktop = inputs.nixpkgs.lib.nixosSystem {
    modules = [
      self.modules.nixos.desktop-hardware
      self.modules.nixos.desktop-config
      self.modules.nixos.desktop-modules
    ];
  };

  flake.modules.nixos.desktop-options = { ... }: {
    configuration.machine.hostname = "desktop";
    configuration.machine.host = "desktop";
    configuration.user = user;

    configuration.muteOnLock = false;
    configuration.screenTimeout = false;
  };

  flake.modules.homeManager.desktop-options = { ... }: {
    programs.zsh.shellAliases = {
      coding = "cd $HOME/Documents/Coding/";
    };
  };

  flake.modules.nixos.desktop-modules = { ... }:
    config.flake.lib.loadNixosAndHM config modules user;
}
