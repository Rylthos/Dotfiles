{
  description = "Flake for Pico development";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

  outputs = { self, nixpkgs, ... }:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in {
      devShells.${system}.default = pkgs.mkShell {
        nativeBuildInputs = with pkgs; [
          cmake
          gnumake
          newlib

          minicom

          # gcc-arm-none-eabi
          # libnewlibp-arm-none-eabi

          gcc-arm-embedded-9
        ];

        buildInputs = with pkgs; [
        ];

        PICO_SDK_PATH="/home/aaron/Documents/Coding/Arduino/pico-sdk";
      };
    };
}
