{ pkgs, lib, config, ... }:
    with lib;
    let cfg = config.modules.wofi;
in {
    options.modules.wofi = { enable = mkEnableOption "wofi"; };
    config = mkIf cfg.enable {
        programs.wofi = {
            enable = true;
        };
    };
}
