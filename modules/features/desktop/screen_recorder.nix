{ self, ... }: {
  flake.modules.nixos.desktop-screen-recorder = { pkgs, ... }: {
    programs.gpu-screen-recorder.enable = true;
  };

  flake.modules.homeManager.desktop-screen-recorder = { pkgs, ... }: {
    home.packages = with pkgs; [
      gpu-screen-recorder
      gpu-screen-recorder-gtk
      killall
    ];

    wayland.windowManager.hyprland = {
      settings = {
        bind = [
          "SUPER SHIFT, XF86Launch8, exec, $NIXOS_SCRIPTS_DIR/ToggleScreenReplay.sh" # F13
          "SUPER SHIFT, XF86Launch9, exec, $NIXOS_SCRIPTS_DIR/screen_recorder/save_replay.sh" # F14
        ];
      };
    };
  };
}
