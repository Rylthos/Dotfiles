{ pkgs, lib, config, ... }:
    with lib;
    let cfg = config.modules.razer;
in {
    options.modules.razer = { enable = mkEnableOption "razer"; };
    config = mkIf cfg.enable {
        home.packages = with pkgs; [
            razergenie
            openrazer-daemon
        ];
    };
}
