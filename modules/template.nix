{ pkgs, lib, config, ... }:
    with lib;
    let cfg = config.modules.#NAME;
in {
    options.modules.#NAME = { enable = mkEnableOption "#NAME"; };
    config = mkIf cfg.enable {
    };
}
