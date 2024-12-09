{ pkgs, lib, config, ... }:
    with lib;
    let cfg = config.modules.python;
in {
    options.modules.python = { enable = mkEnableOption "python"; };
    config = mkIf cfg.enable {
        home.packages = with pkgs; [
            (pkgs.python312.withPackages (ppkgs: [
                ppkgs.matplotlib
                ppkgs.numpy
                ppkgs.scipy
                ppkgs.pyserial
                ppkgs.ipython
                ppkgs.pygments
                ppkgs.pillow
                ppkgs.opencv-python
            ]))
        ];
    };
}
