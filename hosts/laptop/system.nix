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

        libinput.enable = true;

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

        # Login Manager
        greetd = {
            enable = true;
            settings = {
                default_session.command = ''
                ${pkgs.tuigreet}/bin/tuigreet \
                --time \
                --asterisks \
                --user-menu \
                --remember \
                --remember-session \
                --cmd start-hyprland
                '';
            };
        };
    };

    environment = {
        variables = {
            CODING = "$HOME/Documents/Coding";
            CAMBRIDGE_WORK = "$HOME/Documents/Cambridge/PartII/";
            CAMBRIDGE_SUPO = "$HOME/Documents/Cambridge/PartII/Supervisions/";
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

    hardware = {
        opentabletdriver.enable = true;
        graphics.extraPackages = with pkgs; [
        ];
    };

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
            plugins = with pkgs; [ thunar-volman thunar-archive-plugin thunar-vcs-plugin ];
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


    virtualisation.podman = {
        enable = true;
        dockerCompat = true;
    };

    environment.systemPackages = [ pkgs.distrobox ];

    services.udev.packages = [
        (pkgs.writeTextFile {
            name = "teensy_udev";
            text = ''
                ATTRS{idVendor}=="16c0", ATTRS{idProduct}=="04*", ENV{ID_MM_DEVICE_IGNORE}="1", ENV{ID_MM_PORT_IGNORE}="1"
                ATTRS{idVendor}=="16c0", ATTRS{idProduct}=="04[789a]*", ENV{MTP_NO_PROBE}="1"
                KERNEL=="ttyACM*", ATTRS{idVendor}=="16c0", ATTRS{idProduct}=="04*", MODE:="0666", RUN:="/run/current-system/sw/bin/stty -F /dev/%k raw -echo"
                KERNEL=="hidraw*", ATTRS{idVendor}=="16c0", ATTRS{idProduct}=="04*", MODE:="0666"
                SUBSYSTEMS=="usb", ATTRS{idVendor}=="16c0", ATTRS{idProduct}=="04*", MODE:="0666"
                KERNEL=="hidraw*", ATTRS{idVendor}=="1fc9", ATTRS{idProduct}=="013*", MODE:="0666"
                SUBSYSTEMS=="usb", ATTRS{idVendor}=="1fc9", ATTRS{idProduct}=="013*", MODE:="0666"
            '';
            destination = "/etc/udev/rules.d/00-teensy.rules";
         })

        (pkgs.writeTextFile {
            name = "picotootls";
            text = ''
                SUBSYSTEM=="usb", ATTRS{idVendor}=="2e8a", ATTRS{idProduct}=="0003", MODE="660", GROUP="plugdev"
                SUBSYSTEM=="usb", ATTRS{idVendor}=="2e8a", ATTRS{idProduct}=="000a", MODE="660", GROUP="plugdev"
            '';
            destination = "/etc/udev/rules.d/90-picotools.rules";
         })
    ];
}
