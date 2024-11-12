{ pkgs, lib, config, ... }:
    with lib;
    let cfg = config.modules.dev_packages;
in {
    options.modules.dev_packages = { enable = mkEnableOption "dev_packages"; };
    config = mkIf cfg.enable {
        home.packages = with pkgs; [

            # C/Cpp
            clang-tools
            clang
            cmake
            cmake-language-server
            ninja
            gdb
            valgrind
            libsForQt5.kcachegrind

            # Graphics
            shaderc
            # glslang
            # spirv-tools
            renderdoc

            # Python
            python312Packages.matplotlib
            python312Packages.numpy
            python312Packages.scipy
        ];
    };
}
