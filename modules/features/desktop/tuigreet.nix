{ self, ... }: {
  flake.modules.nixos.desktop-tuigreet = { pkgs, ... }: {
    services.greetd = {
      enable = true;
      settings = {
        default_session.command = ''
          ${pkgs.tuigreet}/bin/tuigreet \
          --time \
          --asterisks \
          --user-menu \
          --remember
          --remember-session
          --cmd start-hyprland
        '';
      };
    };

    environment.etc."greetd/environments".text = ''
      start-hyprland
      '';
  };
}
