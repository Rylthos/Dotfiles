{ self, lib, ... }: {
  flake.modules.nixos.desktop-config = { config, ... }: {
    hardware = {
      opentabletdriver.enable = true;

      nvidia = {
        package = config.boot.kernelPackages.nvidiaPackages.stable;
        modesetting.enable = true;
        open = true;
        powerManagement = {
          enable = false;
          finegrained = false;
        };
      };
    };

    services.xserver.videoDrivers = [ "nvidia" ];

    nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  };
}
