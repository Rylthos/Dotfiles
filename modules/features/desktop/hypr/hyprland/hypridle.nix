{ self, lib, ... }: {
  flake.modules.nixos.desktop-hypridle = { pkgs, config, ... }: {
      config.configuration.hyprlandLua = lib.mkAfter (
          if config.configuration.screenTimeout then [
            "hl.on('hyprland.start', function() hl.exec_cmd('${pkgs.hypridle}/bin/hypridle') end)"
          ] else []);
  };

  flake.modules.homeManager.desktop-hypridle = { osConfig, ... }: let
  in {
    services.hypridle = {
      enable = true;
      settings = {
        general = {
          lock_cmd = "pidof hyprlock || ${osConfig.configuration.lockScript}/bin/lock";
          before_sleep_cmd = "loginctl lock-session";
          after_sleep_cmd = "hyprctl dispatch dpms on";
        };

        listener = [
        {
          timeout = 150;
          on-timeout = "brightnessctl -s set 10";
          on-resume = "brightnessctl -r";
        }
        {
          timeout = 150;
          on-timeout = "brightnessctl -sd rgb:kbd_backlight set 0";
          on-resume = "brightnessctl -rd rgb:kbd_backlight";
        }
        {
          timeout = 300;
          on-timeout = "loginctl lock-session";
        }
        {
          timeout = 330;
          on-timeout = "hyprctl dispatch dpms off";
          on-resume = "hyprctl dispatch dpms on";
        }
        {
          timeout = 1800;
          on-timeout = "systemctl suspend";
        }
        ];
      };
    };
  };
}
