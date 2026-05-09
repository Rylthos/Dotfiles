{ self, lib, ... }: let
target_version = "570.123.07";
values = "-1024 -1024 600";
version = "1.1.0";
in {
  flake.modules.homeManager.desktop-nvibrant = { pkgs, ... }: let
    nvibrant_src = fetchTarball {
      url = "https://github.com/Tremeschin/nvibrant/releases/download/v${version}/nvibrant-${version}-bin.tar.gz";
      sha256 = "0d1i5b7dpbfimsq8nbcjs9l24xk8gddbmhvdjs1jld7g38rflxpz";
    };

    nvibrant = pkgs.stdenv.mkDerivation {
      pname = "nvibrant";
      version = "${version}";
      src = nvibrant_src;

      installPhase = ''
        runHook preInstall
        mkdir -p $out/bin
        install -m 755 $src/nvibrant-linux-amd64-${target_version}-v${version}.bin $out/bin/nvibrant
        runHook postInstall
        '';

      buildInputs = [ pkgs.stdenv.cc.cc.lib pkgs.gcc pkgs.glibc ];
      nativeBuildInputs = [ pkgs.patchelf pkgs.autoPatchelfHook ];
    };
  in {
    home.packages = [ nvibrant ];

    wayland.windowManager.hyprland = {
      settings = {
        exec-once = lib.mkAfter [
          "${nvibrant}/bin/nvibrant ${values}"
        ];
      };
    };
  };
}
