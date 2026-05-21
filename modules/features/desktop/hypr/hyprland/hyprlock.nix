{ self, lib, ... }: {

  flake.modules.nixos.desktop-hyprlock = { config, pkgs, ... }: let
    lockScript = pkgs.pkgs.writeShellScriptBin "lock" (
        ''
        grim -l 0 /tmp/current_screen.png &
        '' + (lib.optionalString config.configuration.muteOnLock) ''
        wpctl set-mute @DEFAULT_AUDIO_SINK@ 1 &
        '' + ''
        playerctl --all-players stop &
        sudo /run/current-system/sw/bin/pkill evtest
        wait &&
        hyprlock
        ''
        );
  in {
    config.configuration.lockScript = lockScript;

    config.configuration.hyprlandLua = lib.mkAfter [
        "hl.bind('SUPER + ALT_L + L', hl.dsp.exec_cmd('${config.configuration.lockScript}/bin/lock'))"
    ];
  };

  flake.modules.homeManager.desktop-hyprlock = { pkgs, osConfig, ... }: {
    home.packages = with pkgs; [
      grim
    ];

    programs.hyprlock = {
      enable = true;
      settings = {
        background = [
          {
            path = "/tmp/current_screen.png";
            blur_passes = 1;
            blur_size = 7;
            noise = 1.17e-2;
          }
        ];

        label = [
          {
            text = "$TIME";
            color = "rgba(242, 243, 244, 0.75)";
            font_size = 95;
            font_family = "CaskaydiaCoveNerdFont";
            position = "0, 300";
            halign = "center";
            valign = "center";
          }
          {
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
          path = "/home/${osConfig.configuration.user}/Pictures/profile.png";

          position = "0, 50";
          halign = "center";
          valign = "center";
        };

        input-field = {
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
