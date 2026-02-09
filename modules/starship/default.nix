{ pkgs, lib, config, ... }:
    with lib;
    let cfg = config.modules.starship;
in {
    options.modules.starship = { enable = mkEnableOption "starship"; };
    config = mkIf cfg.enable {
        programs.starship = {
            enable = true;
            settings = {
                add_newline = false;
                format = "$username$hostname$nix_shell$git_branch$git_commit$git_state$git_status$directory$jobs$cmd_duration$character";
                username = {
                    style_user = "#${config.colorScheme.palette.base05} bold";
                    style_root = "#${config.colorScheme.palette.base08} bold";
                };
                hostname = {
                    style = "#${config.colorScheme.palette.base0B} bold";
                    ssh_only = true;
                };
                nix_shell = {
                    symbol = "";
                    format = "[$symbol$name]($style) ";
                    style = "#${config.colorScheme.palette.base0E} bold";
                };
                git_branch = {
                    only_attached = true;
                    format = "[$symbol$branch]($style) ";
                    symbol = "";
                    style = "#${config.colorScheme.palette.base0A} bold";
                };
                git_commit = {
                    only_detached = true;
                    format = "[ﰖ$hash]($style) ";
                    style = "#${config.colorScheme.palette.base0A} bold";
                };
                git_state = {
                    style = "#${config.colorScheme.palette.base0E} bold";
                };
                git_status = {
                    style = "#${config.colorScheme.palette.base0B} bold";
                };
                directory = {
                    read_only = " ";
                    truncation_length = 0;
                };
                cmd_duration = {
                    format = "[$duration]($style) ";
                    style = "#${config.colorScheme.palette.base0D}";
                };
                jobs = {
                    style = "#${config.colorScheme.palette.base0B} bold";
                };
                character = {
                    success_symbol = "[\\$](#${config.colorScheme.palette.base0B} bold)";
                    error_symbol = "[\\$](#${config.colorScheme.palette.base08} bold)";
                };
            };
        };
    };
}
