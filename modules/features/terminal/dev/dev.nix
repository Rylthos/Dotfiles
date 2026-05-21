{ self, config, ... }: {
  flake.modules.homeManager.terminal-dev-packages = { pkgs, config, ... }: {
    home.packages = with pkgs; [
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
      clang-tools
      gf # GDB frontend

## Graphics
      glslang
      glsl_analyzer

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

# Markdown
      marksman
    ] ++ (lib.optionals (hostname == "laptop")) [
      rgp
    ];

    home.file.".clang-format" = {
      source = config.lib.file.mkOutOfStoreSymlink /home/aaron/.dotfiles/modules/dev_packages/.clang-format;
    };
  };
}
