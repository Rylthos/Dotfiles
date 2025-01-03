{ inputs, pkgs, lib, config, ... }:
    with lib;
    let cfg = config.modules.spotify;
in {
    imports = [
        inputs.spicetify-nix.homeManagerModules.default
    ];

    options.modules.spotify = { enable = mkEnableOption "spotify"; };
    config = mkIf cfg.enable {

        # home.packages = with pkgs; [
        #     # spotify
        # ];

        programs.spicetify = 
        let spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.system}; in {
            enable = true;
            theme = spicePkgs.themes.hazy;

            enabledExtensions = with spicePkgs.extensions; [
                keyboardShortcut
                shuffle
                history
                betterGenres
                autoSkip
                groupSession
            ];
        };
    };
}
