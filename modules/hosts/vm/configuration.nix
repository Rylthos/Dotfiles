{ self, lib, ... }: {
  flake.modules.nixos.vm-config = { pkgs, ... }: {
    users.users.vm = {
      isNormalUser = true;
      initialPassword = "test";
    };

    virtualisation = {
      vmVariant = {
        virtualisation = {
          graphics = true;
          memorySize = 4096;
          cores=4;

          qemu.options = [
            "-vga" "virtio"
            "-display" "gtk,gl=on"
          ];
        };
      };
    };

    nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";

    nix.settings.trusted-users = [ "vm" ];
  };
}
