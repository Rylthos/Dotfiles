{ self, ... }: {
  flake.modules.nixos.base-firewall = { ... }: {
    networking.firewall.enable = true;
  };
}
