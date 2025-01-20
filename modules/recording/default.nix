{ pkgs, lib, config, ... }:
    with lib;
    let cfg = config.modules.recording;
in {
    options.modules.recording = { enable = mkEnableOption "recording"; };

    config = mkIf cfg.enable {
        home.packages = with pkgs; [
            obs-studio
       ];
    };
}
