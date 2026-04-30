{ self, lib, ... }: {
  flake.modules.nixos.vm-config = { pkgs, ... }: {
    users.users.vm = {
      isNormalUser = true;
      initialPassword = "test";
    };

    nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";

    nix.settings.trusted-users = [ "vm" ];
  };
}
