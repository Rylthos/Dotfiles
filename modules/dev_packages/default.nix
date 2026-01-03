{ pkgs, lib, config, nixpkgs, ... }:
    with lib;
   let cfg = config.modules.dev_packages;
in {
    options.modules.dev_packages = { enable = mkEnableOption "dev_packages"; };
    config = mkIf cfg.enable {
        home.packages = with pkgs; [
            ## Debugging
            lldb_20
            vscode-extensions.vadimcn.vscode-lldb.adapter

            ## Python
            pyright

            ## C/Cpp
            # clang-tools
            # clang
            cmake
            cmake-language-server
            ninja
            gdb
            valgrind
            tracy
            kdePackages.kcachegrind
            gnumake

            ## Graphics
            glslang
            glsl_analyzer
            rgp

            ## Nixos
            nixd

            ## Rust
            rustup

            # Webdev
            vscode-langservers-extracted
            typescript-language-server
            prettier

            # Prolog
            swi-prolog
        ];

        home.file.".clang-format" = {
            source = config.lib.file.mkOutOfStoreSymlink /home/aaron/.dotfiles/modules/dev_packages/.clang-format;
        };
    };
}
