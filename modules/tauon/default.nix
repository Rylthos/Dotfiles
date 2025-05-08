{ inputs, pkgs, lib, config, ... }:
    with lib;
    let cfg = config.modules.tauon;
in {
    options.modules.tauon = { enable = mkEnableOption "tauon"; };
    config = mkIf cfg.enable {
        home.packages = with pkgs; [
            tauon
        ];
    };
}
