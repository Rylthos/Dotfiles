{ self, ... }: {
  flake.modules.nixos.base-security = { pkgs, ... }: {
    security = {
      polkit.enable = true;
      sudo = {
        enable = true;
        extraRules = [
        {
          groups = [ "wheel" ];
          commands = [
          {
            command = "${pkgs.evtest}";
            options = [ "NOPASSWD" ];
          }
          {
            command = "/run/current-system/sw/bin/pkill";
            options = [ "NOPASSWD" ];
          }
          ];
        }
        ];
      };
    };
  };
}
