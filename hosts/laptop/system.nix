{ config, pkgs, inputs, ... }:
let 
    p = pkgs.writeScriptBin "charge-upto" ''
        echo 80 > /sys/class/power_supply/BAT0/charge_control_end_threshold
    '';
in
{
    services = {
        gvfs.enable = true;
        udisks2.enable = true;
        devmon.enable = true;

        power-profiles-daemon.enable = false;
        blueman.enable = true;

        auto-cpufreq = {
            enable = true;
            settings = {
                battery = {
                    governor = "powersave";
                    turbo = "never";
                };
                charger = {
                    governor = "performance";
                    turbo = "auto";
                };
            };
        };

        # tlp = {
        #     enable = true;
        #     settings = {
        #         CPU_SCALING_GOVERNER_ON_AC = "performance";
        #         CPU_SCALING_GOVERNER_ON_BAT = "powersave";
        #
        #         CPU_ENERGY_PERF_POLICY_ON_AC = "performance";
        #         CPU_ENERGY_PERF_POLICY_ON_BAT = "power";
        #
        #         CPU_MIN_PERF_ON_AC = 0;
        #         CPU_MAX_PERF_ON_AC = 100;
        #         CPU_MIN_PERF_ON_BAT = 0;
        #         CPU_MAX_PERF_ON_BAT = 90;
        #
        #         START_CHARGE_THRESH_BAT0 = 60;
        #         STOP_CHARGE_THRESH_BAT0 = 80;
        #     };
        # };

        # Login Manager
        greetd = {
            enable = true;
            settings = {
                default_session.command = ''
                ${pkgs.greetd.tuigreet}/bin/tuigreet \
                --time \
                --asterisks \
                --user-menu \
                --remember \
                --remember-session \
                --cmd Hyprland
                '';
            };

            vt = 1;
        };
    };

    environment = {
        variables = {
            CODING = "$HOME/Documents/Coding";
            CAMBRIDGE_WORK = "$HOME/Documents/Cambridge/PartIB/";
            CAMBRIDGE_SUPO = "$HOME/Documents/Cambridge/PartIB/Supervisions/";
        };

        sessionVariables = {
            MOZ_USE_XINPUT2 = "1";
            NIXOS_OZONE_WL = "1";
            WLR_NO_HARDWARE_CURSOR = "1";
            XCURSOR_SIZE = "24";
            AMD_VULKAN_ICD="RADV";
        };
    };

    environment.etc."greetd/environments".text = ''
        Hyprland
    '';

    hardware.graphics.extraPackages = with pkgs; [
        amdvlk
    ];

    services.displayManager = {
        sddm = {
            enable = true;
            enableHidpi = true;
            theme = "breeze";
            wayland.enable = true;

            settings = {
                X11 = {
                    server = "-dpi 178";
                };
            };
        };
    };

    programs = {
        thunar = {
            enable = true;
            plugins = with pkgs.xfce; [ thunar-volman ];
        };

        steam = {
            enable = true;
        };

        wireshark.enable = true;
    };

    systemd.services.battery-charge-threshold = {
        wantedBy = [ "local-fs.target" "suspend.target" ];
        after = [ "local-fs.target" "suspend.target" ];
        description = "Set the battery charge threshold to a value";
        startLimitBurst = 5;
        startLimitIntervalSec = 1;
        serviceConfig = {
            Type="oneshot";
            Restart="on-failure";
            ExecStart ="${pkgs.runtimeShell} -c 'echo 80 > /sys/class/power_supply/BAT0/charge_control_end_threshold'";
        };
    };


    virtualisation.virtualbox.host.enable = true;
    # virtualisation.virtualbox.guest.enable = true;
    virtualisation.virtualbox.guest.dragAndDrop = true;
}
