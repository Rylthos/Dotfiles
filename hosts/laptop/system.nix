{ config, pkgs, inputs, ... }:
{
    services = {
        gvfs.enable = true;
        udisks2.enable = true;

        power-profiles-daemon.enable = false;
        blueman.enable = true;

        tlp = {
            enable = true;
            settings = {
                CPU_SCALING_GOVERNER_ON_AC = "performance";
                CPU_SCALING_GOVERNER_ON_BAT = "powersave";

                CPU_ENERGY_PERF_POLICY_ON_AC = "performance";
                CPU_ENERGY_PERF_POLICY_ON_BAT = "power";

                CPU_MIN_PERF_ON_AC = 0;
                CPU_MAX_PERF_ON_AC = 100;
                CPU_MIN_PERF_ON_BAT = 0;
                CPU_MAX_PERF_ON_BAT = 90;

                START_CHARGE_THRESH_BAT0 = 60;
                STOP_CHARGE_THRESH_BAT0 = 80;
            };
        };

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
    };

    virtualisation.virtualbox.host.enable = true;
    # virtualisation.virtualbox.guest.enable = true;
    virtualisation.virtualbox.guest.dragAndDrop = true;
}
