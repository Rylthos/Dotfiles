{ config, lib, pkgs, inputs, hostname, ... }:
{
    environment.defaultPackages = [ ];

    programs = {
        fish.enable = true;
        dconf.enable = true;
        ssh.startAgent = true;
        gamemode.enable = true;
    };

    environment.systemPackages = with pkgs; [
        libsForQt5.breeze-icons

        libnotify

        xsettingsd
        xorg.xrdb

        python312Packages.pyserial

        man-pages
        man-pages-posix

        wireguard-tools
        protonvpn-gui
    ];
    documentation.dev.enable = true;

    fonts = {
        fontDir.enable = true;
        enableDefaultPackages = true;
        packages = with pkgs; [
            nerd-fonts.caskaydia-cove
            corefonts
            # (nerdfonts.override { fonts = [ "CascadiaCode" ]; })
        ];
    };

    xdg = {
        portal = {
            enable = true;
            xdgOpenUsePortal = true;
            config.common.default = "*";
            extraPortals = with pkgs; [
                xdg-desktop-portal-wlr
                xdg-desktop-portal-hyprland
                xdg-desktop-portal-gtk
            ];
        };
    };

    nix = {
        # settings.auto-optimise-store = true;
        optimise.automatic = true;
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

        settings = {
            download-buffer-size = 524288000; # 500 MiB
        };
    };

    nixpkgs.config = {
      allowUnfree = true;
      allowUnfreePredicate = (_: true);
    };

    # Not yet updated in nixpkgs
    nixpkgs.overlays = [
        (_: prev: {
            hyprutils = prev.hyprutils.overrideAttrs (_: {
                src = prev.fetchFromGitHub {
                    owner = "hyprwm";
                    repo = "hyprutils";
                    tag = "v0.10.0";
                    hash = "sha256-r1ed7AR2ZEb2U8gy321/Xcp1ho2tzn+gG1te/Wxsj1A=";
                };
            });
         })
    ];

    boot = {
        kernel.sysctl = {
            "kernel.printk" = "3 3 3 3";
        };
        tmp.cleanOnBoot = true;
        loader = {
            systemd-boot.enable = true;
            systemd-boot.editor = false;
            systemd-boot.configurationLimit = 5;
            efi.canTouchEfiVariables = true;

            systemd-boot = {
                windows = lib.mkIf (hostname == "desktop") {
                    # "sdc2" = {
                    #     title = "Windows 10";
                    #     efiDeviceHandle = "FS0";
                    # };
                };
            };
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
        extraGroups = [ "networkmanager" "wheel" "render" "video" "dialout" "wireshark" ];
        shell = pkgs.fish;
    };

    users.extraGroups.vboxusers.members = [ "aaron" ];

    networking = {
        hostName = "aaron-nixos-" + hostname;
        networkmanager.enable = true;
    };

    environment = {
        variables = {
            NIXOS_CONFIG_DIR = "$HOME/.dotfiles";
            NIXOS_DEV_DIR = "$NIXOS_CONFIG_DIR/dev";
            NIXOS_MODULES_DIR = "$NIXOS_CONFIG_DIR/modules";
            NIXOS_SCRIPTS_DIR = "$NIXOS_MODULES_DIR/scripts";

            MOZ_ENABLE_WAYLAND = "1";
            EDITOR = "nvim";
            QT_QPA_PLATFORM = "wayland;xcb";
            QT_QPA_PLATFORMTHEME = "qt5ct";
            QT_STYLE_OVERRIDE = "kvantum";
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

    services.pulseaudio.enable = false;

    security.rtkit.enable = true;
    hardware = {
        bluetooth.enable = true;
        bluetooth.powerOnBoot = false;

        graphics = {
            enable = true;
        };
    };

    services.openssh = {
        enable = true;
        openFirewall = true;
        ports = [ 22 ];
        settings = {
            PasswordAuthentication = true;
            AllowUsers = null;
            UseDns = true;
            X11Forwarding = false;
            PermitRootLogin = "prohibit-password";
        };
    };

    networking.firewall = {
        enable = true;
        allowedTCPPorts = [
            22
        ];
    };

    services.tumbler.enable = true;

    services.pipewire = {
        enable = true;
        alsa.enable = true;
        alsa.support32Bit = true;
        pulse.enable = true;
    };

    programs.gpu-screen-recorder.enable = true;

    programs.mosh.enable = true;

    system.stateVersion = "24.11";
}
