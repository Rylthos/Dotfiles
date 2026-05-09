{ self, lib, ... }: {
  flake.modules.homeManager.gaming-steam = { pkgs, ... }: {
    home.packages = with pkgs; [
      steam
    ];
  };

  flake.modules.nixos.gaming-steam = { ... }: {
    programs.steam = {
      enable = true;
      gamescopeSession.enable = true;
    };
  };
}
