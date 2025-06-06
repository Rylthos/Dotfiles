{ pkgs, lib, config, ... }:
    with lib;
    let cfg = config.modules.mako;
in {
    options.modules.mako = { enable = mkEnableOption "mako"; };

    config = mkIf cfg.enable {
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
