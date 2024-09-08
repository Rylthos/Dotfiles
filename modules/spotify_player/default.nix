{ pkgs, lib, config, ... }:
    with lib;
    let cfg = config.modules.spotify_player;
in {
    options.modules.spotify_player = { enable = mkEnableOption "spotify_player"; };
    config = mkIf cfg.enable {
        home.packages = with pkgs; [
            spotify-player
        ];

        home.file."${config.xdg.configHome}/spotify-player/app.toml" = {
            source = ./app.toml;
        };
    };
}
