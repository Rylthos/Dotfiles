{ self, ... }: {
  flake.modules.nixos.base-nix = { ... }: {
    nixpkgs.config = {
      allowUnfree = true;
      allowUnfreePredicate = (_: true);
    };

    nix = {
      # settings.auto-optimise-store = true;
      optimise.automatic = true;
      settings.allowed-users = [ "aaron" ];
      gc = {
        automatic = true;
        dates = "weekly";
        options = "--delete-older-than 7d";
      };
      extraOptions = ''
        experimental-features = nix-command flakes
        keep-outputs = true
        keep-derivations = true
      '';

      settings = {
        download-buffer-size = 524288000; # 500 MiB
      };
    };
  };
}
