{ pkgs, lib, config, ... }:
    with lib;
    let cfg = config.modules.recording;
in {
    options.modules.recording = { enable = mkEnableOption "recording"; };

    config = mkIf cfg.enable {
        home.packages = with pkgs; [
            obs-studio-plugins.wlrobs
            obs-studio
            rnnoise-plugin
            (kdePackages.kdenlive.overrideAttrs (prevAttrs: {
                                     nativeBuildInputs = (prevAttrs.nativeBuildInputs or [ ]) ++ [ makeBinaryWrapper ];
                                     postInstall = (prevAttrs.postInstall or "") + ''
                                         wrapProgram $out/bin/kdenlive --prefix LADSPA_PATH : ${rnnoise-plugin}/lib/ladspa
                                     '';
                                     }))
       ];
    };
}
