{ self, lib, config, ... }: let
    currentPath = "$NIXOS_MODULES_DIR/features/desktop/waybar/";
    colorScheme = config.colorScheme;
in {
  flake.modules.homeManager.desktop-waybar = { pkgs, config, osConfig, ... }: {
    home.packages = with pkgs; [
      pamixer
        pwvucontrol
    ];

    programs.waybar = {
      enable = true;

      settings = [{
        layer = "top";
        position = "top";
        height = 32;
        margin = "4 0 0 0";

        modules-left = [
          "custom/padding"
            "custom/dome-left"
            "hyprland/workspaces"
            "custom/dome-right"
        ];

        modules-right = [
          "custom/dome-left"
            "network"
            "pulseaudio"
            "bluetooth"
            "battery"
            "backlight"
            "custom/background"
            "clock"
            "custom/background"
            "custom/power"
            "custom/dome-right"
            "custom/padding"
        ];

        "hyprland/workspaces" = {
          format = "{name}";
          persistent-workspaces = {
            "*" = 10;
          };
        };

        network = {
          interval = 2;
          format-disconnected = "󱚼 ";
          format = "{bandwidthUpBytes} {bandwidthDownBytes}";
          tooltip = true;
          tooltip-format-wifi = "{essid} {signalStrength}󱉸";
          on-click-right = "nm-connection-editor";
        };

        pulseaudio = {
          format = "{icon} {volume:2}󱉸";
          format-muted = "MUTE";
          format-icons = {
            headphones = "";
            default = [
              "󰕿"
                "󰖀"
                "󰕾"
            ];
          };
          scroll-step = 5;
          on-click = "pamixer -t";
          on-click-middle = "$NIXOS_SCRIPTS_DIR/SelectAudio.sh";
          on-click-right = "pwvucontrol";
        };

        bluetooth = {
          format-on = "󰂯";
          format-off = "󰂲";
          format-connected = "󰂱";
          tooltip = true;

          tooltip-format = "{status} {device_alias}";

          on-click = "$NIXOS_SCRIPTS_DIR/ToggleBluetooth.sh";
          on-click-right = "blueman-manager";
        };

        battery = {
          states = {
            good = 95;
            warning = 30;
            critical = 15;
          };
          format = "{capacity:2}󱉸 {icon} {time}";
          format-time = "{H} h {M} min";
          tooltip-format = "{power:3} watts";
          interval = 10;
          format-icons = {
            charging = [
              "󰢜"
                "󰂆"
                "󰂇"
                "󰂈"
                "󰢝"
                "󰂉"
                "󰢞"
                "󰂊"
                "󰂋"
                "󰂅"
            ];
            default = [
              "󰁺"
                "󰁻"
                "󰁼"
                "󰁽"
                "󰁾"
                "󰁿"
                "󰂀"
                "󰂁"
                "󰂂"
                "󰁹"
            ];
          };
        };

        backlight = {
          interval = 5;
          format = "{percent}󱉸 {icon}";
          format-icons = [
            ""
              ""
              ""
              ""
              ""
              ""
              ""
              ""
              ""
          ];
          tooltip = false;
        };

        clock = {
          format = "{:%d-%m %H:%M:%S}";
          interval = 1;
          tooltip = true;
          timezone = "GB";
          tooltip-format = "<tt><small>{calendar}</small></tt>";

          calendar = {
            mode = "year";
            mode-mon-col = 3;
            weeks-pos = "right";
            on-scroll = 1;
            on-click-right = "mode";
            format = {
              months =   "<span color='#ffead3'><b>{}</b></span>";
              days =     "<span color='#ecc6d9'><b>{}</b></span>";
              weeks =    "<span color='#99ffdd'><b>W{}</b></span>";
              weekdays = "<span color='#ffcc66'><b>{}</b></span>";
              today =    "<span color='#ff6699'><b><u>{}</u></b></span>";
            };
          };

          actions = {
            on-click-right = "mode";
            on-click-forward = "tz_up";
            on-click-backward = "tz_down";
            on-scroll-up = "shift_up";
            on-scroll-down = "shift_down";
          };
        };

        "custom/power" = {
          format = "⏻";
          tooltip = false;
          on-click = "wlogout -b 4 -s -c 10 -T 400 -L 410 -R 410 -B 400";
        };

        "custom/padding" = {
          format = " ";
          tooltip = false;
        };

        "custom/dome-left" = {
          format = " ";
          tooltip = false;
        };

        "custom/dome-right" = {
          format = " ";
          tooltip = false;
        };
      }

      {
        layer = "top";
        position = "bottom";
        height = 32;
        margin = "0 0 4 0";

        modules-left = [
          "custom/padding"
            "custom/dome-left"
            "user"
            "memory"
            "cpu"
            "load"
            "temperature"
            "disk"
            "custom/previous_song"
            "custom/play_pause_song"
            "custom/next_song"
            "mpris"
            "custom/dome-right"
        ];

        modules-right = [
          "custom/dome-left"
        ] ++ (lib.optionals (osConfig.configuration.enableScreenRecorder) [
            "custom/toggle_screen_replay"
        ]) ++ [
        "custom/toggle_rotation"
          "custom/toggle_keyboard"
          "idle_inhibitor"
          "custom/background"
          "custom/dome-right"
          "custom/padding"
        ];

        user = {
          format = "{work_d}:{work_H}:{work_M}";
          icon = false;
          open-on-click = false;
        };

        memory = {
          interval = 5;
          format = " {}󱉸";
        };

        cpu = {
          interval = 5;
          format = " {usage:2}󱉸";
        };

        load = {
          interval = 5;
          format = "{load1:0.1f}";
        };

        temperature = {
          interval = 5;
          format = "{icon} {temperatureC}°C";
          thermal-zone = (
              if osConfig.configuration.machine.hostname == "desktop" then
              1
              else
              0
              );
          format-icons = [
            ""
          ];
          tooltip = false;
        };

        disk = {
          interval = 30;
          format = " {specific_free:0.1f}{specific_total:0.1f} GB";
          unit = "GB";
        };

        "custom/previous_song" = {
          format = "";
          tooltip = false;
          on-click = "playerctl previous";
        };

        "custom/play_pause_song" = {
          exec = "${currentPath}/get_playerctl_playing_icon.py";
          interval = 2;
          format = "{}";
          tooltip = false;
          on-click = "playerctl play-pause";
        };

        "custom/next_song" = {
          format = "";
          tooltip = false;
          on-click = "playerctl next";
        };

        mpris = {
          format = "<b>{dynamic}</b>";
          format-paused = "<b>{dynamic}</b>";
          dynamic-order = [ "title" "position" "length" ];
          ignored-players = [ "firefox" ];
          dynamic-len = 50;
          player-icons =  {
            default = "▶";
          };
          status-icons = {
            paused = "⏸";
          };
        };

        "custom/toggle_screen_replay" = {
          format = "{icon}";
          format-icons = {
            "enabled" = "󰄀";
            "disabled" = "󰗟";
          };
          tooltip = false;
          exec = "$NIXOS_SCRIPTS_DIR/ToggleScreenReplay.sh icon";
          return-type = "json";
          interval = 1;
          on-click = "$NIXOS_SCRIPTS_DIR/ToggleScreenReplay.sh";
          on-click-middle = "$NIXOS_SCRIPTS_DIR/screen_recorder/save_replay.sh";
        };


        "custom/toggle_rotation" = {
          format = "{icon}";
          format-icons = {
            "rotated" = "";
            "normal" = "";
          };
          tooltip = false;
          exec = "$NIXOS_SCRIPTS_DIR/ToggleScreenRotation.sh icon";
          return-type = "json";
          interval = 1;
          on-click = "$NIXOS_SCRIPTS_DIR/ToggleScreenRotation.sh";
        };

        "custom/toggle_keyboard" = {
          format = "{icon}";
          format-icons = {
            "enabled" = "󰌌";
            "disabled" = "󰌐";
          };
          tooltip = false;
          exec = "$NIXOS_SCRIPTS_DIR/ToggleKeyboard.sh icon";
          return-type = "json";
          interval = 1;
          on-click = "$NIXOS_SCRIPTS_DIR/ToggleKeyboard.sh";
        };

        idle_inhibitor = {
          format = "{icon}";
          tooltip = false;
          format-icons = {
            activated = " ";
            deactivated = " ";
          };
        };

        "custom/background" = {
          format = "󰲍 ";
          tooltip = false;
          on-click = "$NIXOS_SCRIPTS_DIR/wallpaper/RandomWallpaper.sh";
          on-click-middle = "$NIXOS_SCRIPTS_DIR/wallpaper/WallpaperPicker.sh";
          on-click-right = "$NIXOS_SCRIPTS_DIR/wallpaper/ToggleWallpaperLoop.sh";
        };

        "custom/padding" = {
          format = " ";
          tooltip = false;
        };

        "custom/dome-left" = {
          format = " ";
          tooltip = false;
        };

        "custom/dome-right" = {
          format = " ";
          tooltip = false;
        };
      }];

      style = ''
* {
  font-size: 20px;
  font-family: monospace;
}

window#waybar {
  background: transparent;
}

#workspaces button {
  padding: 0 1px;
  min-width: 15px;
  color: #${colorScheme.palette.base04};
}

#workspaces button.empty {
  color: #${colorScheme.palette.base01};
}

#workspaces button.active {
  color: #${colorScheme.palette.base0D};
}

#workspaces button:hover,
#custom-power:hover,
#custom-toggle_screen_replay:hover,
#custom-play_pause_song:hover,
#custom-next_song:hover,
#custom-previous_song:hover,
#custom-background:hover,
#custom-toggle_rotation:hover,
#custom-toggle_keyboard:hover,
#idle_inhibitor:hover {
  background: #${colorScheme.palette.base03};
  border: #${colorScheme.palette.base03};
}

#network {
  color: #${colorScheme.palette.base09};
}

#pulseaudio {
  color: #${colorScheme.palette.base0D};
}

#bluetooth {
  color: #${colorScheme.palette.base04};
}

#bluetooth.on {
  color: #${colorScheme.palette.base0C};
}

#bluetooth.connected {
  color: #${colorScheme.palette.base0D};
}

#battery {
  color: #${colorScheme.palette.base0B};
}

#battery.charging {
  color: #${colorScheme.palette.base08};
}

#backlight {
  color: #${colorScheme.palette.base07};
}

#memory {
  color: #${colorScheme.palette.base0C};
}

#load,
#cpu {
  color: #${colorScheme.palette.base0A};
}

#temperature {
  color: #${colorScheme.palette.base08};
}

#disk {
  color: #${colorScheme.palette.base0D};
}

#mpris {
  background: #${colorScheme.palette.base00};
}

#clock,
#custom-power,
#user,
#custom-previous_song,
#custom-play_pause_song,
#custom-next_song,
#mpris,
#custom-toggle_screen_replay,
#custom-toggle_rotation,
#custom-toggle_keyboard,
#idle_inhibitor,
#custom-background {
  color: #${colorScheme.palette.base06};
}

#workspaces,
#network,
#pulseaudio,
#bluetooth,
#battery,
#backlight,
#clock,
#custom-power,
#user,
#memory,
#cpu,
#load,
#temperature,
#disk,
#custom-previous_song,
#custom-play_pause_song,
#custom-next_song,
#mpris,
#custom-toggle_screen_replay,
#custom-toggle_rotation,
#custom-toggle_keyboard,
#idle_inhibitor,
#custom-background {
  background: #${colorScheme.palette.base00};
}

#custom-padding {
  background: transparent;
}

#custom-dome-right,
#custom-dome-left {
  background: #${colorScheme.palette.base00};
}

#custom-dome-left {
  border-top-left-radius: 13px;
  border-bottom-left-radius: 13px;
}

#custom-dome-right {
  border-top-right-radius: 13px;
  border-bottom-right-radius: 13px;
}


@import "/home/aaron/.config/waybar/styles/padding.css";
    ''; };

    xdg.configFile."waybar/styles/padding.css".source =  config.lib.file.mkOutOfStoreSymlink "/home/aaron/.dotfiles/modules/waybar/padding.css";
    xdg.configFile."waybar/styles/mediaplayer_style.css".source =  config.lib.file.mkOutOfStoreSymlink "/home/aaron/.dotfiles/modules/waybar/waybar-mediaplayer/src/style.css";
  };
}
