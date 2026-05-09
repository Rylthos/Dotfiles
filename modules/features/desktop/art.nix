{ self, ... }: {
  flake.modules.homeManager.desktop-art = { pkgs, ... }: {
    home.packages = with pkgs; [
      inkscape
      krita
      gimp
    ];
  };

}
