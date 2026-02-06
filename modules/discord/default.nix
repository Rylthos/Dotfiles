{ pkgs, lib, config, ... }:
    with lib;
    let cfg = config.modules.discord;
in {
    options.modules.discord = { enable = mkEnableOption "discord"; };
    config = mkIf cfg.enable {
        home.packages = with pkgs; [
            discord
            # (pkgs.discord.override {
            #     withOpenASAR = true;
            #     withVencord = true;
            # })
        ];

        programs.vesktop = {
            enable = true;

            vencord.settings = {
                autoUpdate = true;
                autoUpdateNotification = true;
                notifyAboutUpdates = true;
            };
        };
    };
}
