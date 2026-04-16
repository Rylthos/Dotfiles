{ pkgs, lib, config, ... }:
    with lib;
    let cfg = config.modules.yazi;
in {
    options.modules.yazi = { enable = mkEnableOption "yazi"; };
    config = mkIf cfg.enable {
        programs.yazi = {
            enable = true;
            shellWrapperName = "y";
        };
    };
}
