{ config, pkgs, inputs, ... }:
{
    environment.defaultPackages = [ ];
    services.xserver.desktopManager.xterm.enable = false;

    programs = {
        fish.enable = true;
        dconf.enable = true;
        ssh.startAgent = true;
    };

    environment.systemPackages = with pkgs; [
        libsForQt5.breeze-icons
    ];

    fonts = {
        fontDir.enable = true;
        enableDefaultPackages = true;
        packages = with pkgs; [
            (nerdfonts.override { fonts = [ "CascadiaCode" ]; })
        ];
    };

    xdg = {
        portal = {
            enable = true;
            config.common.default = "*";
            extraPortals = with pkgs; [
                xdg-desktop-portal-wlr
                xdg-desktop-portal-gtk
            ];
        };
    };

    nix = {
        settings.auto-optimise-store = true;
        settings.allowed-users = [ "aaron" ];
        gc = {
            automatic = true;
            dates = "weekly";
            options = "--delete-older-than 7d";
        };
        extraOptions = ''
            experimental-features = nix-command flakes
            keep-outputs = true
            keep-derivations = true
        '';
    };

    nixpkgs.config = {
      allowUnfree = true;
      allowUnfreePredicate = (_: true);
    };

    boot = {
        tmp.cleanOnBoot = true;
        loader = {
            systemd-boot.enable = true;
            systemd-boot.editor = false;
            systemd-boot.configurationLimit = 5;
            efi.canTouchEfiVariables = true;
        };
    };

    time.timeZone = "Europe/London";
    i18n = {
        defaultLocale = "en_GB.UTF-8";
        extraLocaleSettings = {
            LC_ADDRESS = "en_GB.UTF-8";
            LC_IDENTIFICATION = "en_GB.UTF-8";
            LC_MEASUREMENT = "en_GB.UTF-8";
            LC_MONETARY = "en_GB.UTF-8";
            LC_NAME = "en_GB.UTF-8";
            LC_NUMERIC = "en_GB.UTF-8";
            LC_PAPER = "en_GB.UTF-8";
            LC_TELEPHONE = "en_GB.UTF-8";
            LC_TIME = "en_GB.UTF-8";
        };
    };
    console.keyMap = "uk";

    users.users.aaron = {
        isNormalUser = true;
        description = "Aaron Danton";
        extraGroups = [ "networkmanager" "wheel" "render" "video" "dialout" ];
        shell = pkgs.fish;
    };

    networking = {
        hostName = "aaron-nixos";
        networkmanager.enable = true;
    };

    environment = {
        variables = {
            NIXOS_CONFIG_DIR = "$HOME/.dotfiles";
            NIXOS_MODULES_DIR = "$NIXOS_CONFIG_DIR/modules";
            NIXOS_SCRIPTS_DIR = "$NIXOS_MODULES_DIR/scripts";

            MOZ_ENABLE_WAYLAND = "1";
            EDITOR = "nvim";
            QT_QPA_PLATFORM = "wayland;xcb";
            QT_QPA_PLATFORMTHEME = "qt5ct";
        };
    };

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

    security.rtkit.enable = true;
    hardware = {
        pulseaudio.enable = false;

        bluetooth.enable = true;
        bluetooth.powerOnBoot = false;

        graphics = {
            enable = true;
        };
    };

    services.tumbler.enable = true;

    services.pipewire = {
        enable = true;
        alsa.enable = true;
        alsa.support32Bit = true;
        pulse.enable = true;
    };

    system.stateVersion = "24.11";
}
