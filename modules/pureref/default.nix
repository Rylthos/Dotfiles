{ pkgs, lib, config, ... }:
with lib;
let cfg = config.modules.pureref;
in {
    options.modules.pureref = { enable = mkEnableOption "pureref"; };
    config = mkIf cfg.enable {
        home.packages = with pkgs; [
            pureref
        ];
    };
}
