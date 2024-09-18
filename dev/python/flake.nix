{
  description = "Flake for Python development";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

  outputs = { self, nixpkgs, ... }:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in {
      devShells.${system}.default = pkgs.mkShell {
        nativeBuildInputs = with pkgs; [
          python312Packages.matplotlib
          python312Packages.numpy
        ];

        buildInputs = with pkgs; [
        ];
      };
    };
}
