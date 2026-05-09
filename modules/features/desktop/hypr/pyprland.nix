{ self, config, lib, ... }: {
  flake.modules.homeManager.desktop-pyprland = { pkgs, ... }: {
    home.packages = with pkgs; [
      pyprland
    ];

    wayland.windowManager.hyprland.settings = {
      exec-once = lib.mkAfter [
        "pypr"
      ];

      bind = [
        "SUPER, T, exec, pypr toggle term"
        "SUPER, P, exec, pypr toggle spotify_tui"
        "SUPER, C, exec, pypr toggle calc"
      ];
    };

    xdg.configFile."pypr/config.toml".source = (pkgs.formats.toml {}).generate "pypr_config" {
      pyprland = {
        plugins = [
          "scratchpads"
        ];
      };

      scratchpads = {
        term = {
          animation = "fromTop";
          command = "alacritty --class Alacritty-dropdown-term";
          class = "Alacritty-dropdown-term";
          size = "75% 60%";
          max_size = "1920px 100%";
          margin = 50;
          unfocus = "hide";
          hysteresis = 0.4;
          lazy = true;
        };

        spotify_tui = {
          animation = "fromTop";
          command = "alacritty --class spotify-tui-dropdown -e spotify_player";
          class = "spotify-tui-dropdown";
          size = "75% 60%";
          max_size = "1920px 100%";
          margin = 50;
          unfocus = "hide";
          hysteresis = 0.4;
          lazy = true;
        };

        calc = {
          animation = "fromRight";
          command = "alacritty --class octave-calculator -e octave -q";
          class = "octave-calculator";
          size = "30% 50%";
          max_size = "1920px 100%";
          margin = 50;
# unfocus = "hide";
          hysteresis = 0.4;
          lazy = true;
        };

        spotify = {
          animation = "fromTop";
          command = "spotify --class spotify-dropdown";
          class = "spotify-dropdown";
          size = "75% 60%";
          max_size = "1920px 100%";
          margin = 50;
          unfocus = "hide";
          hysteresis = 0.4;
          lazy = true;
        };
      };
    };
  };
}
