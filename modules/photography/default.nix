{ pkgs, lib, config, ... }:
    with lib;
    let cfg = config.modules.photography;
in {
    options.modules.photography = { enable = mkEnableOption "photography"; };
    config = mkIf cfg.enable {
        home.packages = with pkgs; [
            digikam
            darktable
            siril
        ];
    };
}
