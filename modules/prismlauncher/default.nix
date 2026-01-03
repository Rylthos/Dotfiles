{ pkgs, lib, config, nix-colors, ... }:
with lib;
let cfg = config.modules.prismlauncher;
in {
    options.modules.prismlauncher = { enable = mkEnableOption "prismlauncher"; };
    config = mkIf cfg.enable {
        home.packages = with pkgs; [
            prismlauncher
        ];
    };
}
