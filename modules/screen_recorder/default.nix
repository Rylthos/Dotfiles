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

        wayland.windowManager.hyprland = {
            settings = {
                bind = [
                    "SUPER SHIFT, XF86Launch8, exec, $NIXOS_SCRIPTS_DIR/ToggleScreenReplay.sh" # F13
                    "SUPER SHIFT, XF86Launch9, exec, $NIXOS_MODULES_DIR/screen_recorder/save_replay.sh" # F14
                ];
            };
        };
    };
}
