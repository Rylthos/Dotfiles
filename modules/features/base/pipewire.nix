{ self, ... }: {
  flake.modules.nixos.base-pipewire = {
    services.pipewire = {
      enable = true;
      alsa.enable = true;
      jack.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      wireplumber = {
        extraConfig = {
        };
      };
    };
  };
}
