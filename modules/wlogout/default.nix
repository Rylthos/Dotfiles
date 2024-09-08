{ pkgs, lib, config, ... }:
with lib;
    let
        cfg = config.modules.wlogout;
        wlogout_icons = "/home/aaron/.dotfiles/modules/wlogout/icons/";
in {
    options.modules.wlogout = { enable = mkEnableOption "wlogout"; };
    config = mkIf cfg.enable {
        programs.wlogout = {
            enable = true;

            layout = [
                {
                    label = "lock";
                    action = "loginctl lock-session";
                    text = "Lock";
                    keybind = "l";
                    circular = true;
                }
                {
                    label = "logout";
                    action = "loginctl terminate-user $USER";
                    text = "Logout";
                    keybind = "e";
                    circular = true;
                }
                {
                    label = "shutdown";
                    action = "systemctl poweroff";
                    text = "Shutdown";
                    keybind = "s";
                    circular = true;
                }
                {
                    label = "reboot";
                    action = "systemctl reboot";
                    text = "Reboot";
                    keybind = "r";
                    circular = true;
                }
            ];

            style =
                let lock_icon = "./icons/lock.png"; in
                let logout_icon = "./icons/logout.png"; in
                let shutdown_icon = "./icons/shutdown.png"; in
                let reboot_icon = "./icons/reboot.png"; in ''
                * {
                    background-image: none;
                    box-shadow: none;
                }

                window {
                    background-color: rgba(0, 0, 0, 0.1);
                }

                button {
                    background-color: #${config.colorScheme.palette.base00};
                    border-style: solid;
                    border-width: 1px;
                    border-radius: 10px;
                    background-repeat: no-repeat;
                    background-position: center;
                    background-size: 25%;
                    color: #${config.colorScheme.palette.base06};
                }

                button:focus, button:active, button:hover {
                    background-color: #${config.colorScheme.palette.base04};
                    color: #${config.colorScheme.palette.base06};
                    outline-style: none;
                }

                #lock {
                    background-image: image(url("${lock_icon}"), url("${lock_icon}"));
                }

                #logout {
                    background-image: image(url("${logout_icon}"), url("${logout_icon}"));
                }

                #shutdown {
                    background-image: image(url("${shutdown_icon}"), url("${shutdown_icon}"));
                }

                #reboot {
                    background-image: image(url("${reboot_icon}"), url("${reboot_icon}"));
                }
                '';
            };

            home.file."${config.xdg.configHome}/wlogout/icons/" = {
              source = ./icons;
              recursive = true;
            };
        };
    }
