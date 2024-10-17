{ pkgs, lib, config, ... }:
with lib;
let
    cfg = config.modules.pyprland;
in {
    options.modules.pyprland = { enable = mkEnableOption "pyprland"; };
    config = mkIf cfg.enable {
        home.packages = with pkgs; [
          pyprland
        ];

        wayland.windowManager.hyprland.settings = {
            exec-once = [
               "pypr"
            ];

            bind = [
              "SUPER, T, exec, pypr toggle term"
              "SUPER, P, exec, pypr toggle spotify"
            ];
        };

xdg.configFile."hypr/pyprland.toml".source = (pkgs.formats.toml {}).generate "something" {
          pyprland = {
            plugins = [
              "scratchpads"
            ];
          };

          scratchpads.term = {
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

          scratchpads.spotify = {
            animation = "fromTop";
            command = "alacritty --class Alacritty-dropdown-spotify -e spotify_player";
            class = "Alacritty-dropdown-spotify";
            size = "75% 60%";
            max_size = "1920px 100%";
            margin = 50;
            unfocus = "hide";
            hysteresis = 0.4;
            lazy = true;
          };
        };
    };
}
