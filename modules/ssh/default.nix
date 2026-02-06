{ pkgs, lib, config, ... }:
with lib;
let cfg = config.modules.ssh;
in {
    options.modules.ssh = { enable = mkEnableOption "ssh"; };
    config = mkIf cfg.enable {
        programs.ssh = {
            enable = true;
            enableDefaultConfig = false;
            matchBlocks = {
                "github.com" = {
                    identityFile = "~/.ssh/id_github";
                    addKeysToAgent = "yes";
                    hostname = "github.com";
                    host = "github.com";
                    user = "git";
                    identitiesOnly = true;
                };
            };
        };
    };
}
