{ pkgs, lib, config, ... }:
    with lib;
    let cfg = config.modules.wofi;
in {
    options.modules.wofi = { enable = mkEnableOption "wofi"; };
    config = mkIf cfg.enable {
        programs.wofi = {
            enable = true;
            settings = {
                location = "center";
                width = 800;
                height = 600;
                sort = "alphabetical";
                no_actions = true;
            };
            style = ''
window {
    margin: 0px;
    border: 1px solid #${config.colorScheme.palette.base02};
    background-color: #${config.colorScheme.palette.base00};
}

#input {
    margin: 5px;
    border: none;
    color: #${config.colorScheme.palette.base05};
    background-color: #${config.colorScheme.palette.base03};
}

#inner-box {
    margin: 5px;
    border: none;
    background-color: #${config.colorScheme.palette.base03};
}

#outer-box {
    margin: 5px;
    border: none;
    background-color: #${config.colorScheme.palette.base02};
}

#scroll {
    margin: 0px;
    padding-bottom: 5px;
    border: none;
}

#text {
    margin: 5px;
    border: none;
    color: #${config.colorScheme.palette.base05};
}

#entry:selected {
    background-color: #${config.colorScheme.palette.base04};
}
            '';
        };
    };
}
