{ pkgs, lib, config, ... }:
    with lib;
    let cfg = config.modules.screen_recorder;
in {
    options.modules.screen_recorder = { enable = mkEnableOption "screen_recorder"; };
    config = mkIf cfg.enable {
        home.packages = with pkgs; [
            gpu-screen-recorder
            gpu-screen-recorder-gtk
            killall
        ];
    };
}
