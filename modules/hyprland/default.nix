{ pkgs, lib, config, hostname, inputs, hyprland, ... }:
with lib;
let
    cfg = config.modules.hyprland;

    startupScript = pkgs.pkgs.writeShellScriptBin "start" (''
      $NIXOS_SCRIPTS_DIR/WaybarStart.sh &
      swww-daemon &

      sleep 1
    '' + (lib.optionalString config.modules.hypridle.enable) ''
      hypridle &
    '' + ''
      $NIXOS_SCRIPTS_DIR/wallpaper/RandomWallpaperLoop.sh &
      echo $! > /tmp/BackgroundLoop.pid
    '' + (lib.optionalString (hostname == "laptop") ''
        hyprshade on custom-vibrance &
    '') + (lib.optionalString (hostname == "desktop") ''
        hyprshade on custom-vibrance-desktop &
    ''));
in {
    options.modules.hyprland = { enable = mkEnableOption "hyprland"; };
    config = mkIf cfg.enable {
        home.file."${config.xdg.configHome}/hypr" = {
            source = ./hypr;
            recursive = true;
        };

        home.packages = with pkgs; [
            swww
            hypridle
            hyprshade
            brightnessctl

            bluez

            networkmanagerapplet

            xdg-user-dirs
        ];

        xdg.configFile."hypr/shaders" = {
            source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.dotfiles/modules/hyprland/hypr/shaders";
            recursive = true;
        };

        wayland.windowManager.hyprland = {
            enable = true;

            importantPrefixes = ["plugin" "$" "bezier" "name" "source"];

            plugins = [
                inputs.hy3.packages.x86_64-linux.hy3
                inputs.hyprsplit.packages.x86_64-linux.hyprsplit
            ];

            package = inputs.hyprland.packages.x86_64-linux.hyprland;

            settings = {
                exec-once = [
                    "${startupScript}/bin/start"
                ];

                "$terminal" = "alacritty";
                "$fileManager" = "thunar";

                debug = {
                    disable_logs = false;
                };

                source = "~/.config/hypr/catppuccin_macchiato.conf";

                general = {
                    monitor = [
                    ] ++ (lib.optionals (hostname == "laptop")) [
                        "eDP-1, 2880x1800@90, 0x0, 1.8"
                    ] ++ (lib.optionals (hostname == "desktop")) [
                        "DP-1,prefererred,0x0,1"
                        "DP-2,prefererred,auto-right,1"
                    ];
                    border_size = 1;
                    gaps_out = 5;
                    gaps_in = 2;

                    "col.active_border" = "rgba(FF0000CC) rgba(FF8700CC) rgba(FFD300CC) rgba(DEFF0ACC) rgba(A1FF0ACC) rgba(0AFF99CC) rgba(0AEFFFCC) rgba(147DF5CC) rgba(580AFFCC) rgba(BE0AFFCC) 90deg";
                    "col.inactive_border" = "rgba(147DF588) 45deg";

                    layout = "hy3";
                };

                input = {
                    kb_layout = "gb";
                    touchpad = {
                        natural_scroll = "yes";
                        scroll_factor = 0.5;
                    };
                };

                master = {
                    new_status = "slave";
                    mfact = 0.5;
                    orientation="center";
                };

                dwindle = {
                    smart_split = true;
                };

                misc = {
                    vfr = true;
                    disable_hyprland_logo = true;
                    disable_splash_rendering = true;
                };

                render = {
                    cm_sdr_eotf = 2;
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

                    active_opacity = 1.0;
                    inactive_opacity = 1.0;

                    blur = {
                        enabled = true;
                        size = 8;
                        passes = 2;
                    };

                    shadow = {
                        enabled = true;
                        range = 4;
                    };
                };

                gestures = {
                    workspace_swipe_touch = true;
                    workspace_swipe_cancel_ratio = 0.3;
                };

                windowrule = [
                    "match:initial_class GLFW, float on"
                    "match:initial_class GLFW, render_unfocused on"

                    "match:initial_class Alacritty, opacity 0.65 0.65"

                    "match:class org.kde.digikam, match:title (^New Album), float on"

                    {
                        name = "floating firefox window - resize and center";
                        "match:class" = "firefox";
                        "match:float" = true;
                        size = "(0.5*monitor_w) (0.5*monitor_h)";
                        center = "on";
                    }

                    {
                        name = "Position PiP firefox";

                        "match:class" = "firefox";
                        "match:title" = "Picture-in-Picture";

                        float = "on";
                        pin = "on";
                        move = "(0.7*monitor_w-5) (0.05*monitor_h+5)";
                        size = "(0.3*monitor_w) (0.3*monitor_h)";
                    }

                    {
                        name = "Position PiP Discord";

                        "match:class" = "vesktop";
                        "match:initial_title" = "(Discord Popout)";

                        float = "on";
                        pin = "on";
                        move = "(0.8*monitor_w) (0.05*monitor_h)";
                        persistent_size = "on";
                    }

                    {
                        name = "Position Pavu control";

                        "match:class" = "(com.saivert.pwvucontrol)";

                        float = "on";
                        center = "on";
                        persistent_size = "on";
                        size = "(0.6*monitor_w) (0.6*monitor_h)";
                    }

                    {
                        name = "Position blueman manager";

                        "match:class" = ".blueman-manager-wrapped";

                        float = "on";
                        center = "on";
                        size = "(0.6*monitor_w) (0.6*monitor_h)";
                    }

                    {
                        name = "Position nm-connection-editor";

                        "match:class" = "nm-connection-editor";

                        float = "on";
                        center = "on";
                        size = "(0.6*monitor_w) (0.6*monitor_h)";
                    }

                    "match:class tracy, render_unfocused on"

                    {
                        name = "Fix steam games";

                        "match:class" = "(^steam_app_[0-9]*)";

                        render_unfocused = "on";
                        fullscreen = "on";
                        idle_inhibit = "focus";
                    }
                ];

                bindm = [
                    "SUPER, mouse:272, movewindow"
                    "SUPER, mouse:273, resizewindow"
                ];

                binde = [
                    ", XF86AudioRaiseVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+"
                    ", XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
                    ", XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"

                    ", XF86AudioPlay, exec, playerctl play-pause"
                    ", XF86AudioNext, exec, playerctl next"
                    ", XF86AudioPrev, exec, playerctl previous"

                    ", XF86MonBrightnessUp, exec, brightnessctl s 5%+"
                    ", XF86MonBrightnessDown, exec, brightnessctl s 5%-"

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
                    "SUPER, R, exec, $NIXOS_SCRIPTS_DIR/AppLauncher.sh"

                    "SUPER SHIFT, Q, killactive"
                    "SUPER, SPACE, togglefloating"
                    "SUPER, F, fullscreen"
                    "SUPER, M, exit"
                    "SUPER, U, exec, hyprctl setprop active opaque toggle"
                    "SUPER SHIFT, P, pin"

                    "CONTROL_ALT, DELETE, exec, wlogout -b 4 -s -c 10 -T 400 -L 410 -R 410 -B 400"

                    ", Print, exec, $NIXOS_SCRIPTS_DIR/Screenshot.sh"

                    "SUPER, H, hy3:movefocus, l, visible, warp"
                    "SUPER, L, hy3:movefocus, r, visible, warp"
                    "SUPER, K, hy3:movefocus, u, visible, warp"
                    "SUPER, J, hy3:movefocus, d, visible, warp"

                    "SUPER SHIFT, H, hy3:movewindow, l, once"
                    "SUPER SHIFT, L, hy3:movewindow, r, once"
                    "SUPER SHIFT, K, hy3:movewindow, u, once"
                    "SUPER SHIFT, J, hy3:movewindow, d, once"

                    "SUPER, 1, split:workspace, 1"
                    "SUPER, 2, split:workspace, 2"
                    "SUPER, 3, split:workspace, 3"
                    "SUPER, 4, split:workspace, 4"
                    "SUPER, 5, split:workspace, 5"
                    "SUPER, 6, split:workspace, 6"
                    "SUPER, 7, split:workspace, 7"
                    "SUPER, 8, split:workspace, 8"
                    "SUPER, 9, split:workspace, 9"
                    "SUPER, 0, split:workspace, 10"

                    "SUPER SHIFT, 1, split:movetoworkspace, 1"
                    "SUPER SHIFT, 2, split:movetoworkspace, 2"
                    "SUPER SHIFT, 3, split:movetoworkspace, 3"
                    "SUPER SHIFT, 4, split:movetoworkspace, 4"
                    "SUPER SHIFT, 5, split:movetoworkspace, 5"
                    "SUPER SHIFT, 6, split:movetoworkspace, 6"
                    "SUPER SHIFT, 7, split:movetoworkspace, 7"
                    "SUPER SHIFT, 8, split:movetoworkspace, 8"
                    "SUPER SHIFT, 9, split:movetoworkspace, 9"
                    "SUPER SHIFT, 0, split:movetoworkspace, 10"

                    "SUPER , G, split:grabroguewindows"
                    "SUPER , D, split:swapactiveworkspaces, current+1"
                ];

                gesture = [
                    "3, horizontal, workspace"
                ];

                device = [
                    {
                        name = "elan9008:00-04f3:2e36-stylus";
                        output = "eDP-1";
                        sensitivity = 0.0;
                        accel_profile = "flat";
                    }
                    {
                        name = "elan9008:00-04f3:2e36";
                        output = "eDP-1";
                    }
                ];
            };

            extraConfig = ''
                plugin {
                    hy3 {
                        autotile {
                            enable = true
                            trigger_width = 800
                            trigger_height = 600
                        }
                    }
                    hyprsplit {
                        num_workspaces = 10
                        persistent-workspaces = true
                    }
                }
            '';
        };
    };
}
