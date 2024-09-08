{ pkgs, lib, config, ... }:
    with lib;
    let cfg = config.modules.python;
in {
    options.modules.python = { enable = mkEnableOption "python"; };
    config = mkIf cfg.enable {
        home.packages = with pkgs; [
            python3
            python312Packages.ipython
            python312Packages.pygments
            python312Packages.pillow
        ];
    };
}
