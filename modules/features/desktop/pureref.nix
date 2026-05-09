{ self, lib, ... }: {
  flake.modules.homeManager.desktop-pureref = { pkgs, ... }: {
    home.packages = with pkgs; [ pureref ];
  };
}
