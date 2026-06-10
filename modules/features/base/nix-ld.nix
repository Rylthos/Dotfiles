{ self, ... }: {
  flake.modules.nixos.base-nix-ld = { pkgs, ... }: {
    programs.nix-ld = {
      enable = true;
      libraries = with pkgs; [
        alsa-lib
      ];
    };
  };
}
