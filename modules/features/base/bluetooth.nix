{ self, ...}: {
  flake.modules.nixos.base-bluetooth = { ... }: {
    hardware.bluetooth = {
      enable = true;
      powerOnBoot = false;
      settings = {
        General = {
          Enable = "Source,Sink,Media,Socket";
          Experimental = true;
          FastConnectable  = true;
          MultiProfile = "multiple";
        };
      };
    };
  };
}
