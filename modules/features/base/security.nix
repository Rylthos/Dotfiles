{ self, ... }: {
  flake.modules.nixos.base-security = { ... }: {
    security = {
      sudo = {
        enable = true;
        extraRules = [
        {
          groups = [ "wheel" ];
          commands = [
          {
            command = "/etc/profiles/per-user/aaron/bin/evtest";
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
