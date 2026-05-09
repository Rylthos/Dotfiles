{ self, ... }: {
  flake.modules.homeManager.desktop-photography = { pkgs, ... }: {
    home.packages = with pkgs; [
      digikam
      darktable
      lensfun

      hugin

      gphoto2
    ];
  };
}
