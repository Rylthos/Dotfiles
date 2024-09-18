{
  description = "Flake for cpp vulkan development";

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
          ninja

          gdb

          shaderc
          glslang
          spirv-tools

          renderdoc
          valgrind
        ];

        buildInputs = with pkgs; [
          pkg-config
          libxkbcommon

          xorg.libX11
          xorg.libX11.dev
          xorg.libXrandr
          xorg.libXinerama
          xorg.libXcursor
          xorg.libXi

          glfw

          vulkan-headers
          vulkan-loader
          vulkan-validation-layers
          vulkan-extension-layer
          vulkan-tools
          vulkan-tools-lunarg
        ];

        LD_LIBRARY_PATH="${pkgs.vulkan-loader}/lib:${pkgs.vulkan-validation-layers}/lib";
        VULKAN_SDK = "${pkgs.vulkan-headers}";
        VK_LAYER_PATH = "${pkgs.vulkan-validation-layers}/share/vulkan/explicit_layer.d";
      };
    };
}
