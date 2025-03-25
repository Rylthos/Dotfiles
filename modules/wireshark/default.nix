{ pkgs, lib, config, ... }:
    with lib;
    let cfg = config.modules.wireshark;
in {
    options.modules.wireshark = { enable = mkEnableOption "wireshark"; };
    config = mkIf cfg.enable {
        # programs.wireshark.enable = true;

        home.packages = with pkgs; [
            wireshark
        ];
    };
}
