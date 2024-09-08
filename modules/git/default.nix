{ pkgs, lib, config, ... }:
    with lib;
    let cfg = config.modules.git;
in {
    options.modules.git = { enable = mkEnableOption "git"; };
    config = mkIf cfg.enable {
        programs.git = {
            enable = true;
            userName = "Aaron Danton";
            userEmail = "aarondanton04@hotmail.com";
            extraConfig = {
                init = { defaultBranch = "Main"; };
                core = {
                    excludesfile = "$NIXOS_CONFIG_DIR/scripts/gitignore";
                };
            };
        };

        programs.fish = {
            shellAliases = {
                gs = "git status";
                gl = "git log --oneline";
                ga = "git add";
                gc = "git commit";
            };
        };
    };
}
