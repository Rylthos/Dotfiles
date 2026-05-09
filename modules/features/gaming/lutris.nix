{ self, ... }:{
  flake.modules.homeManager.gaming-lutris = { pkgs, pkgsStable, ... }: {
    home.packages = with pkgs; [
      pkgsStable.lutris
      wineWow64Packages.wayland
    ];
  };
}
