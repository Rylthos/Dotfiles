{
  description = "Flake for Webdev development";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

  outputs = { self, nixpkgs, ... }:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in {
      devShells.${system}.default = pkgs.mkShell {
        nativeBuildInputs = with pkgs; [
          nodejs_22

          typescript
          nodePackages.typescript-language-server
          vscode-langservers-extracted
        ];

        buildInputs = with pkgs; [
        ];
      };
    };
}
