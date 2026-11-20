{ self, ... }: {
  flake.modules.homeManager.desktop-photography = { pkgs, ... }: {
    home.packages = with pkgs; [
      digikam

      darktable
      tesseract

      lensfun

      hugin

      gphoto2

      entangle
    ];
  };
}
