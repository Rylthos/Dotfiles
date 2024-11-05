{ pkgs, lib, config, ... }:
    with lib;
    let cfg = config.modules.ncspot;
in {
    options.modules.ncspot= { enable = mkEnableOption "ncspot"; };
    config = mkIf cfg.enable {
        programs.ncspot = {
            enable = true;
        };
    };
}
