{ pkgs, lib, config, ... }:
with lib;
let
    cfg = config.modules.hyprland;

    startupScript = pkgs.pkgs.writeShellScriptBin "start" ''
    $NIXOS_SCRIPTS_DIR/waybar_start.sh &
    swww init &

    sleep 1

    hypridle &

    $NIXOS_SCRIPTS_DIR/RandomBackgroundLoop.sh &
    '';
in {
    options.modules.hyprland = { enable = mkEnableOption "hyprland"; };
    config = mkIf cfg.enable {
        home.file."${config.xdg.configHome}/hypr" = {
            source = ./hypr;
            recursive = true;
        };

        home.packages = with pkgs; [
            swww
            hyprlock
            hypridle
            brightnessctl

            bluez

            networkmanagerapplet

            xdg-user-dirs
        ];

        wayland.windowManager.hyprland = {
            enable = true;

            settings = {
                exec-once = [
                    "${startupScript}/bin/start"
                ];

                "$terminal" = "alacritty";
                "$fileManager" = "thunar";
                "$menu" = "wofi --show drun -M fuzzy";

                source = "~/.config/hypr/catppuccin_macchiato.conf";

                general = {
                    monitor = "eDP-1, 2880x1800@90, 0x0, 1.8";
                    border_size = 2;
                    gaps_out = 5;
                    gaps_in = 5;

                    "col.active_border" = "rgba(FF0000CC) rgba(FF8700CC) rgba(FFD300CC) rgba(DEFF0ACC) rgba(A1FF0ACC) rgba(0AFF99CC) rgba(0AEFFFCC) rgba(147DF5CC) rgba(580AFFCC) rgba(BE0AFFCC) 90deg";
                    "col.inactive_border" = "rgba(147DF588) 45deg";

                    layout = "master";
                };

                input = {
                    kb_layout = "gb";
                    touchpad = {
                        natural_scroll = "yes";
                    };
                };

                master = {
                    new_status = "slave";
                    allow_small_split = true;
                    mfact = 0.5;
                };

                misc = {
                    vfr = true;
                };

                bezier = [
                    "wind, 0.05, 0.9, 0.1, 1.05"
                    "linear, 0.0, 0.0, 1.0, 1.0"
                ];

                animations = {
                    enabled = true;
                    animation = [
                        "border, 1, 10, default"
                        "workspaces, 1, 2, wind"
                    ];
                };

                decoration = {
                    rounding = 10;

                    active_opacity = 0.90;
                    inactive_opacity = 0.80;

                    blur = {
                        enabled = true;
                        size = 20;
                        passes = 1;
                        ignore_opacity = true;
                    };

                    drop_shadow = true;
                    shadow_range = 4;
                };

                gestures = {
                    workspace_swipe = "on";
                };

                windowrulev2 = [
                    "opaque, class:(thunar)"
                    "opaque, class:(firefox)"
                    "opaque, class:(org.kde.okular)"
                    "opaque, class:(org.kde.okular)"
                    "opaque, class:(kicad)"
                    "opaque, class:(FreeCAD)"
                    "opaque, class:(krita)"
                    "opaque, class:(qrenderdoc)"
                    "opacity 0.8 0.8, class:(Alacritty)"

                    "float, class:(feh),title:(feh-float-waybar)"
                    "move onscreen 5% 100%-h, class:(feh),title:(feh-float-waybar)"

                    "float, class:(firefox),title:(Picture-in-Picture)"
                    "pin, class:(firefox),title:(Picture-in-Picture)"
                    "move onscreen 80% 0%, class:(firefox),title:(Picture-in-Picture)"
                ];

                bindm = [
                    "SUPER, mouse:272, movewindow"
                    "SUPER, mouse:273, resizewindow"
                ];

                binde = [
                    ", XF86AudioRaiseVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+"
                    ", XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
                    ", XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"

                    ", XF86MonBrightnessUp, exec, brightnessctl s +10"
                    ", XF86MonBrightnessDown, exec, brightnessctl s 10- -n 10"

                    "SUPER CTRL, H, resizeactive, -10 0"
                    "SUPER CTRL, J, resizeactive, 0 10"
                    "SUPER CTRL, K, resizeactive, 0 -10"
                    "SUPER CTRL, L, resizeactive, 10 0"
                ];

                bind = [
                    "SUPER, RETURN, exec, $terminal"
                    "SUPER, X, exec, xournalpp"
                    "SUPER, S, exec, firefox"
                    "SUPER, E, exec, $fileManager"
                    "SUPER, R, exec, $menu"

                    "SUPER ALT_L, L, exec, hyprlock"

                    "SUPER SHIFT, Q, killactive"
                    "SUPER, SPACE, togglefloating"
                    "SUPER, F, fullscreen"
                    "SUPER, M, exit"
                    "SUPER, U, exec, hyprctl setprop active opaque toggle"
                    "SUPER SHIFT, S, pin"

                    "CONTROL_ALT, DELETE, exec, wlogout -b 4 -s -c 10 -T 400 -L 410 -R 410 -B 400"

                    ", Print, exec, grim -g \"$(slurp -d -w 1)\" $(xdg-user-dir PICTURES)/Screenshots/$(date +'%Y%m%d_%Hh%Mm%Ss_grim.png')"

                    "SUPER, left,  movefocus, l"
                    "SUPER, right, movefocus, r"
                    "SUPER, up,    movefocus, u"
                    "SUPER, down,  movefocus, d"

                    "SUPER, H, movefocus, l"
                    "SUPER, L, movefocus, r"
                    "SUPER, K, movefocus, u"
                    "SUPER, J, movefocus, d"

                    "SUPER SHIFT, H, swapwindow, l"
                    "SUPER SHIFT, L, swapwindow, r"
                    "SUPER SHIFT, K, swapwindow, u"
                    "SUPER SHIFT, J, swapwindow, d"

                    "SUPER, 1, workspace, 1"
                    "SUPER, 2, workspace, 2"
                    "SUPER, 3, workspace, 3"
                    "SUPER, 4, workspace, 4"
                    "SUPER, 5, workspace, 5"
                    "SUPER, 6, workspace, 6"
                    "SUPER, 7, workspace, 7"
                    "SUPER, 8, workspace, 8"
                    "SUPER, 9, workspace, 9"
                    "SUPER, 0, workspace, 10"

                    "SUPER SHIFT, 1, movetoworkspace, 1"
                    "SUPER SHIFT, 2, movetoworkspace, 2"
                    "SUPER SHIFT, 3, movetoworkspace, 3"
                    "SUPER SHIFT, 4, movetoworkspace, 4"
                    "SUPER SHIFT, 5, movetoworkspace, 5"
                    "SUPER SHIFT, 6, movetoworkspace, 6"
                    "SUPER SHIFT, 7, movetoworkspace, 7"
                    "SUPER SHIFT, 8, movetoworkspace, 8"
                    "SUPER SHIFT, 9, movetoworkspace, 9"
                    "SUPER SHIFT, 0, movetoworkspace, 10"
                ];
            };
        };
    };
}
