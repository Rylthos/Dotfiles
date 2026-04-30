{ self, ...}: {
  flake.modules.nixos.base-system = { ... }: {
    system.stateVersion = "26.05";
  };
}
