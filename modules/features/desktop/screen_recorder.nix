{ self, lib, ... }: {
  flake.modules.nixos.desktop-screen-recorder = { pkgs, ... }: {
    config.programs.gpu-screen-recorder.enable = true;

    config.configuration.hyprlandLua = lib.mkAfter [
      "hl.bind('SUPER + SHIFT + XF86Launch8', hl.dsp.exec_cmd('$NIXOS_SCRIPTS_DIR/ToggleScreenReplay.sh'))"
      "hl.bind('SUPER + SHIFT + XF86Launch9', hl.dsp.exec_cmd('$NIXOS_SCRIPTS_DIR/screenRecorder/save_replay.sh'))"
    ];
  };

  flake.modules.homeManager.desktop-screen-recorder = { pkgs, ... }: {
    home.packages = with pkgs; [
      gpu-screen-recorder
      gpu-screen-recorder-gtk
      killall
    ];
  };
}
