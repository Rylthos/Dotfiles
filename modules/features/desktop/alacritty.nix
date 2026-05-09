{ self, config, ... }: {
  flake.modules.homeManager.desktop-alacritty = { ... }: {
    programs.alacritty = {
      enable = true;

      settings = {
        general = {
          live_config_reload = true;
        };

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
  };
}
