{ config, lib, pkgs, inputs, hostname, ... }:
{
    environment.defaultPackages = [ ];

    programs = {
        # fish.enable = true;
        zsh.enable = true;
        dconf.enable = true;
        ssh.startAgent = true;
        gamemode.enable = true;
    };

    environment.systemPackages = with pkgs; [
        libsForQt5.breeze-icons

        libnotify

        xsettingsd
        xrdb

        python312Packages.pyserial

        man-pages
        man-pages-posix

        wireguard-tools
        # protonvpn-gui
    ];
    documentation.dev.enable = true;

    fonts = {
        fontDir.enable = true;
        enableDefaultPackages = true;
        packages = with pkgs; [
            nerd-fonts.caskaydia-cove
            corefonts
        ];
    };

    xdg = {
        portal = {
            enable = true;
            extraPortals = with pkgs; [
                xdg-desktop-portal-hyprland
                xdg-desktop-portal-gtk
                kdePackages.xdg-desktop-portal-kde
            ];
            config.hyprland = {
                default = [ "hyprland" "gtk" ];
            };
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
        shell = pkgs.zsh;
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

    security.rtkit.enable = true;
    hardware = {
        bluetooth = {
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

    services.sunshine = lib.mkIf (hostname == "desktop") {
        enable = true;
        autoStart = true;
        capSysAdmin =  true;
        openFirewall = true;
    };

    networking.firewall = {
        enable = true;
        allowedTCPPorts = [
            22 25565
        ] ++ (lib.optionals (hostname == "desktop")) [ # Sunshine
            47984 47989 47990 48010
        ];
        allowedUDPPortRanges = [
            { from = 25565; to = 25565; }
        ] ++ (lib.optionals (hostname == "desktop")) [ # Sunshine
            { from = 47998; to = 48000; }
            { from = 8000; to = 8010; }
        ];
    };

    services.tumbler.enable = true;

    services.pipewire = {
        enable = true;
        alsa.enable = true;
        jack.enable = true;
        alsa.support32Bit = true;
        pulse.enable = true;
        wireplumber = {
            extraConfig = {
            };
        };
    };

    programs.gpu-screen-recorder.enable = true;

    programs.mosh.enable = true;

    system.stateVersion = "24.11";
}
