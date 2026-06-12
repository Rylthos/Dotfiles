{ self, ... }: {
  flake.modules.nixos.base-services = { ... }: {
    services = {
      dbus.enable = true;

      gvfs.enable = true;
      udisks2.enable = true;
      devmon.enable = true;

      libinput.enable = true;
      blueman = {
        enable = true;
      };

      power-profiles-daemon.enable = false;

      seatd.enable = true;

      # gnome.gcr-ssh-agent = true;

      # displayManager = {
      #   sddm = {
      #     enable = true;
      #     enableHidpi = true;
      #     theme = "breeze";
      #     wayland.enable = true;
      #
      #     settings = {
      #       X11 = {
      #         server = "-dpi 178";
      #       };
      #     };
      #   };
      # };
    };
  };

  flake.modules.homeManager.base-services = { ... }: {
    services.blueman-applet.enable = true;
  };
}
