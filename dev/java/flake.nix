{
  description = "Flake for java development";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

  outputs = { self, nixpkgs, ... }:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in {
      devShells.${system}.default = pkgs.mkShell {
        nativeBuildInputs = with pkgs; [
          (jdk22.override { enableJavaFX=true; })

          maven

          scenebuilder

          jdt-language-server

          astyle
        ];

        buildInputs = with pkgs; [
        ];
      };
    };
}
