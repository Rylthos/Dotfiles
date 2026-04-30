{ self, ... }: {
  flake.modules.nixos.base-fonts = { pkgs, ... }: {
    fonts = {
        fontDir.enable = true;
        enableDefaultPackages = true;
        packages = with pkgs; [
            nerd-fonts.caskaydia-cove
            corefonts
        ];
    };
  };
}
