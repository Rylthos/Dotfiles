{ self, ... }: {
  flake.modules.nixos.base-network = { config, ... }: {
    networking = {
      hostName = "aaron-" + config.configuration.machine.hostname;
      networkmanager.enable = true;
    };
  };
}
