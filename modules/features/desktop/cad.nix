{ self, ... }: {
  flake.modules.homeManager.desktop-cad = { pkgs, ... }: {
    home.packages = with pkgs; [
      kicad
      freecad
      blender
    ];
  };
}
