{ config, pkgs, ... }:
{
    services = {
        gvfs.enable = true;
        udisks2.enable = true;
        devmon.enable = true;

        power-profiles-daemon.enable = false;
        blueman.enable = true;

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
                --cmd Hyprland
                '';
            };
        };
    };

    environment = {
        variables = {
            CODING = "$HOME/Documents/Coding";
            # CAMBRIDGE_WORK = "$HOME/Documents/Cambridge/PartIB/";
            # CAMBRIDGE_SUPO = "$HOME/Documents/Cambridge/PartIB/Supervisions/";
        };

        sessionVariables = {
            MOZ_USE_XINPUT2 = "1";
            NIXOS_OZONE_WL = "1";
            WLR_NO_HARDWARE_CURSOR = "1";
            XCURSOR_SIZE = "24";
        };
    };

    environment.etc."greetd/environments".text = ''
        Hyprland
    '';

    hardware = {
        opentabletdriver.enable = true;
        nvidia = {
            package = config.boot.kernelPackages.nvidiaPackages.vulkan_beta;

            modesetting.enable = true;
            open = true;
            powerManagement = {
                enable = false;
                finegrained = false;
            };
        };
    };

    services.xserver.videoDrivers = [ "nvidia" ];

    services.displayManager.defaultSession = "xfce";

    services.displayManager = {
        sddm = {
            enable = true;
            enableHidpi = true;
            theme = "breeze";
            wayland.enable = true;
        };
    };

    services.xserver = {
        enable = true;
        displayManager.startx.enable = true;
        desktopManager = {
            xterm.enable = false;
            xfce.enable = true;
        };
    };

    programs = {
        thunar = {
            enable = true;
            plugins = with pkgs.xfce; [ thunar-volman ];
        };

        steam = {
            gamescopeSession.enable = true;
            enable = true;
        };

        wireshark.enable = true;
    };

    programs.nix-ld.enable = true;
}
