{ self, ... }: {
  flake.modules.homeManager.desktop-unity = { pkgs, ... }: {
    home.packages = with pkgs; [
      (unityhub.override {
          extraPkgs = pkgs: with pkgs; [
            xdg-utils
          ];
       })
    ];
  };
}
