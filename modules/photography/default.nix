{ pkgs, lib, config, nixpkgs-siril, ... }:
    with lib;
    let cfg = config.modules.photography;
    pkgs-siril = import nixpkgs-siril { system = "x86_64-linux"; };
in {
    options.modules.photography = { enable = mkEnableOption "photography"; };
    config = mkIf cfg.enable {
        home.packages = with pkgs; [
            digikam
            darktable
            lensfun

            pkgs-siril.siril
        ];

    };
}
