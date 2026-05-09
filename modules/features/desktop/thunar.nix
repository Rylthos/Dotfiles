{ self, ... }: {
  flake.modules.nixos.desktop-thunar = { pkgs, ... }: {
    services.tumbler.enable = true;
    programs.thunar = {
      enable = true;
      plugins = with pkgs; [
        thunar-volman
          thunar-archive-plugin
          thunar-vcs-plugin
      ];
    };
  };
}
