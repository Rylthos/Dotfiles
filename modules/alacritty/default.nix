{ pkgs, lib, config, nix-colors, ... }:
with lib;
let cfg = config.modules.alacritty;
in {
    options.modules.alacritty = { enable = mkEnableOption "alacritty"; };
    config = mkIf cfg.enable {
        programs.alacritty = {
            enable = true;

            settings = {
                live_config_reload = true;

                window = {
                    opacity = 0.90;
                    blur = false;
                    dynamic_title = true;
                    dynamic_padding = false;
                };

                font = {
                    normal = {
                        family = "CaskaydiaCoveNerdFont";
                        style = "Regular";
                    };
                    size = 11;
                };

                colors = {
                    cursor = {
                        text = "#1b1e28";
                        cursor = "#ffffff";
                    };
                    normal = {
                        black = "#${config.colorScheme.palette.base03}";
                        red = "#${config.colorScheme.palette.base08}";
                        green = "#${config.colorScheme.palette.base0B}";
                        yellow = "#${config.colorScheme.palette.base0A}";
                        blue = "#${config.colorScheme.palette.base0D}";
                        magenta = "#${config.colorScheme.palette.base0E}";
                        cyan = "#${config.colorScheme.palette.base0C}";
                        white = "#${config.colorScheme.palette.base05}";
                    };
                    dim = {
                        black = "#${config.colorScheme.palette.base03}";
                        red = "#${config.colorScheme.palette.base08}";
                        green = "#${config.colorScheme.palette.base0B}";
                        yellow = "#${config.colorScheme.palette.base0A}";
                        blue = "#${config.colorScheme.palette.base0D}";
                        magenta = "#${config.colorScheme.palette.base0E}";
                        cyan = "#${config.colorScheme.palette.base0C}";
                        white = "#${config.colorScheme.palette.base05}";
                    };
                    bright = {
                        black = "#${config.colorScheme.palette.base03}";
                        red = "#${config.colorScheme.palette.base08}";
                        green = "#${config.colorScheme.palette.base0B}";
                        yellow = "#${config.colorScheme.palette.base0A}";
                        blue = "#${config.colorScheme.palette.base0D}";
                        magenta = "#${config.colorScheme.palette.base0E}";
                        cyan = "#${config.colorScheme.palette.base0C}";
                        white = "#${config.colorScheme.palette.base05}";
                    };
                };

                terminal = {
                    osc52 = "CopyPaste";
                };

                env = {
                    TERM = "xterm-256color";
                };
            };
        };

        home.file."${config.xdg.configHome}/alacritty" = {
            source = ./alacritty;
            recursive = true;
        };
    };
}
