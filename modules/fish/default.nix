{ pkgs, lib, config, ... }:
    with lib;
    let cfg = config.modules.fish;
in {
    options.modules.fish = { enable = mkEnableOption "fish"; };
    config = mkIf cfg.enable {

        programs.fish = {
            enable = true;
            interactiveShellInit = mkBefore "set fish_greeting\n";

            shellAliases = {
                ll = "ls -al";
            };
        };
    };
}
