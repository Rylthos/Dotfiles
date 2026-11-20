{ self, ... }: {
  flake.modules.nixos.base-man = { pkgs, ... }: {
    documentation.dev.enable = true;

    environment.systemPackages = with pkgs; [
      man-pages
      man-pages-posix
    ] ;
  };
}
