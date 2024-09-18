{
  description = "Flake for cpp opengl development";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

  outputs = { self, nixpkgs, ... }:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in {
      devShells.${system}.default = pkgs.mkShell {
        nativeBuildInputs = with pkgs; [
          clang
          clang-tools
          cmake
          gnumake

          gdb

          renderdoc
        ];

        buildInputs = with pkgs; [
          mesa
          libGL
          pkg-config

          wayland
          wayland-utils
          wayland-scanner

          libxkbcommon
          xorg.libX11
          xorg.libX11.dev
          xorg.libXrandr
          xorg.libXinerama
          xorg.libXcursor
          xorg.libXi

          python310
          python310Packages.jinja2
        ];
      };
    };
}
