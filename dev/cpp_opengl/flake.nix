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
          cmake
        ];

        buildInputs = with pkgs; [
          mesa
          libGL
          pkg-config

          python310
          python310Packages.jinja2

          glfw-wayland
        ];
      };
    };
}
