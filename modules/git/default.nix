{ pkgs, lib, config, ... }:
    with lib;
    let cfg = config.modules.git;
in {
    options.modules.git = { enable = mkEnableOption "git"; };
    config = mkIf cfg.enable {
        programs.git = {
            enable = true;
            settings = {
                user = {
                    name = "Aaron Danton";
                    email = "aarondanton04@hotmail.com";
                };
                init = { defaultBranch = "main"; };
                core = {
                    excludesfile = "$NIXOS_CONFIG_DIR/scripts/gitignore";
                };
            };
        };

        home.packages = with pkgs; [
            lazygit
        ];

        programs.zsh = {
            shellAliases = {
                gs = "git status";
                gl = "git log";
                glo = "git log --oneline";
                ga = "git add";
                gc = "git commit";
            };
        };
        programs.fish = {
            shellAliases = {
                gs = "git status";
                gl = "git log";
                glo = "git log --oneline";
                ga = "git add";
                gc = "git commit";
            };
        };
    };
}
