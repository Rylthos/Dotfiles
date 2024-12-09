{
  description = "Flake for ESP32 development";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

  outputs = { self, nixpkgs, ... }:
    let
      system = "x86_64-linux";
      # pkgs = nixpkgs.legacyPackages.${system};

      nixpkgs-esp-dev = builtins.fetchGit {
        url = "https://github.com/mirrexagon/nixpkgs-esp-dev.git";
        rev = "3f748af71ac7890e1f860801fdca2beef65e8353";
      };

      pkgs = import nixpkgs {
        inherit system;
        overlays = [(import "${nixpkgs-esp-dev}/overlay.nix")];
      };
    in {
      devShells.${system}.default = pkgs.mkShell {
        nativeBuildInputs = with pkgs; [
          gcc-arm-embedded
          cmake
          gnumake
          git
          openocd
          esp-idf-full

          minicom
        ];

        buildInputs = with pkgs; [
        ];
      };
    };
}
