{ self, config, ... }: {
  flake.modules.nixos.desktop-mako = { pkgs, ... }: {
    environment.systemPackages = with pkgs; [
      libnotify
    ];
  };
  flake.modules.homeManager.desktop-mako = { ... }: {
    services.mako = {
      enable = true;
      settings = {
        default-timeout = "5000";
        format = "<b>%a ⏵</b> %s\\n%b";
        height = "110";
        width = "300";
        sort = "-time";
        layer = "overlay";
        margin = "5";
        padding = "0,5,10";
        border-size = "2";
        border-color = "#${config.colorScheme.palette.base0D}";
        icons = "true";
        max-icon-size = "64";
        ignore-timeout = "true";
      };
    };
  };
}
