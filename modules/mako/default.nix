{ pkgs, lib, config, ... }:
    with lib;
    let cfg = config.modules.mako;
in {
    options.modules.mako = { enable = mkEnableOption "mako"; };

    config = mkIf cfg.enable {
        services.mako = {
            enable = true;
            defaultTimeout = 5000;
            format = "<b>%a ⏵</b> %s\\n%b";
            height = 110;
            width = 300;
            sort = "-time";
            layer = "overlay";
            margin = "5";
            padding = "0,5,10";
            borderSize = 2;
            borderColor = "#${config.colorScheme.palette.base0D}";
            icons = true;
            maxIconSize = 64;
            ignoreTimeout = true;
        };
    };
}
