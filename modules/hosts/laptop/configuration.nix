{ self, lib, ... }: {
  flake.modules.nixos.laptop-config = { pkgs, ... }: {
    services = {
      auto-cpufreq = {
        enable = true;
        settings = {
          battery = {
            governor = "powersave";
            turbo = "never";

            enable_thresholds = true;
            start_threshold = 60;
            stop_threshold = 80;
          };
          charger = {
            governor = "performance";
            turbo = "auto";
          };
        };
      };
    };

    environment.sessionVariables = {
      AMD_VULKAN_ICD="RADV";
    };

    # systemd.services.battery-charge-threshold = {
    #     wantedBy = [ "local-fs.target" "suspend.target" ];
    #     after = [ "local-fs.target" "suspend.target" ];
    #     description = "Set the battery charge threshold to a value";
    #     startLimitBurst = 5;
    #     startLimitIntervalSec = 1;
    #     serviceConfig = {
    #         Type="oneshot";
    #         Restart="on-failure";
    #         ExecStart ="${pkgs.runtimeShell} -c 'echo 80 > /sys/class/power_supply/BAT0/charge_control_end_threshold'";
    #     };
    # };

    hardware = {
      opentabletdriver.enable = true;

    };

    services.xserver.videoDrivers = [ "amdgpu" ];

    nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  };
}
