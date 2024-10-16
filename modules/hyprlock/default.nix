{ pkgs, lib, config, ... }:
    with lib;
    let cfg = config.modules.hyprlock;

    username = "aaron";

in {
    options.modules.hyprlock = { enable = mkEnableOption "hyprlock"; };
    config = mkIf cfg.enable {
        wayland.windowManager.hyprland.settings = {
            bind = [
                "SUPER ALT_L, L, exec, $NIXOS_SCRIPTS_DIR/hyprlock.sh"
            ];
        };

        programs.hyprlock = {
            enable = true;
            settings = {
                background = [
                    {
                        monitor = "eDP-1";
                        path = "/tmp/current_screen.png";
                        blur_passes = 1;
                        blur_size = 7;
                        noise = 1.17e-2;
                    }
                ];

                label = [
                    {
                        monitor = "eDP-1";
                        text = "$TIME";
                        color = "rgba(242, 243, 244, 0.75)";
                        font_size = 95;
                        font_family = "CaskaydiaCoveNerdFont";
                        position = "0, 300";
                        halign = "center";
                        valign = "center";
                    }
                    {
                        monitor = "eDP-1";
                        text = ''cmd[update:1000] echo $(date +"%A, %B $d")'';
                        color = "rgba(242, 243, 244, 0.75)";
                        font_size = 22;
                        font_family = "CaskaydiaCoveNerdFont";
                        position = "0, 200";
                        halign = "center";
                        valign = "center";
                    }
                ];

                image = {
                    monitor = "eDP-1";
                    path = "/home/${username}/Pictures/profile.png";

                    position = "0, 50";
                    halign = "center";
                    valign = "center";
                };

                input-field = {
                    monitor = "eDP-1";
                    size = "200, 250";
                    outline_thickness = 2;
                    dots_size = 0.2;
                    dots_spacing = 0.35;
                    dots_center = true;
                    outer_color = "rgba(0, 0, 0, 0)";
                    inner_color = "rgba(0, 0, 0, 0.2)";
                    font_color = "rgb(111, 45, 104)";
                    fade_on_empty = false;
                    rounding = -1;
                    check_color = "rgb(30, 107, 204)";
                    placeholder_text = ''<i><span foreground="##cdd6f4">Input Password...</span></i>'';
                    hide_input = false;
                    position = "0, -100";
                    halign = "center";
                    valign = "center";
                };
            };
        };
    };
}
