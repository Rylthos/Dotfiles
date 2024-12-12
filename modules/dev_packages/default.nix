{ pkgs, lib, config, nixpkgs, ... }:
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
            tracy
            libsForQt5.kcachegrind

            # Graphics
            glslang
            glsl_analyzer
            # spirv-tools
            renderdoc

            # Rust
            rustup
            # cargo
            # rustc
        ];
    };
}
