{ self, ... }: {
  flake.modules.nixos.base-hardware = { pkgs, ... }: {
    hardware.graphics = {
      enable = true;
      enable32Bit = true;
    };
  };
}
