{ pkgs, lib, config, ... }:

    with lib;
    let cfg = config.modules.nvibrant;
    target_version = "515.43.04";
    version = "1.1.0";
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

        buildInputs = [ pkgs.gcc ];
        nativeBuildInputs = [ pkgs.patchelf pkgs.autoPatchelfHook ];
    };
in {
    options.modules.nvibrant = { enable = mkEnableOption "nvibrant"; };
    config = mkIf cfg.enable {
        home.packages = with pkgs; [
            nvibrant
        ];

        wayland.windowManager.hyprland = {
            settings = {
                exec-once = [
                    "${nvibrant}/bin/nvibrant"
                ];
            };
        };
    };
}
