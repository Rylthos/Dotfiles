{ self, inputs, lib, ... }: {
  flake.modules.nixos.desktop-hyprland-standalone = { pkgs, config, ... }: let
    startupScript = pkgs.pkgs.writeShellScriptBin "start" (
      ''
        env QML_IMPORT_PATH=$HOME/.config/quickshell qs -p ~/.config/quickshell/shell.qml
        $NIXOS_SCRIPTS_DIR/WaybarStart.sh &
        awww-daemon &

        sleep 1
      '' + ''
        $NIXOS_SCRIPTS_DIR/wallpaper/RandomWallpaperLoop.sh &
        echo $! > /tmp/BackgroundLoop.pid
      '' + (lib.optionalString (config.configuration.machine.host == "laptop") ''
        hyprshade on custom-vibrance &
      '') + (lib.optionalString (config.configuration.machine.host == "desktop") ''
        hyprshade on custom-vibrance-desktop &
      '')
      );
  in {
    config = {
      configuration.hyprlandLua = lib.mkAfter ([
        "hl.on('hyprland.start', function() hl.exec_cmd('${startupScript}/bin/start') end)"
        "hl.on('hyprland.start', function() hl.exec_cmd('hyprctl plugin load ${inputs.hy3.packages.x86_64-linux.hy3}/lib/libhy3.so')end)"
      ] ++ (lib.optionals (config.configuration.machine.host == "laptop")) [
        "hl.monitor({ output='eDP-1', mode='2880x1800@90', position='0x0', scale='1.8' })"
        "hl.config({ decoration = { screen_shader = '/home/aaron/.config/hypr/shaders/custom-vibrance.glsl' } })"
      ] ++ (lib.optionals (config.configuration.machine.host == "desktop")) [
        "hl.monitor({ output='DP-1', mode='preferred', position='0x0', scale='1' })"
        "hl.monitor({ output='DP-2', mode='preferred', position='auto-right', scale='1' })"
        "hl.config({ decoration = { screen_shader = '/home/aaron/.config/hypr/shaders/custom-vibrance-desktop.glsl' } })"
      ]);


      programs.hyprland = {
        enable = true;
        package = inputs.hyprland.packages.x86_64-linux.hyprland;
        portalPackage = inputs.hyprland.packages.x86_64-linux.xdg-desktop-portal-hyprland;
        xwayland.enable = true;
      };

      xdg = {
        portal = {
          enable = true;
          config.common.default = [ "hyprland" "gtk" ];
        };
      };
    };
  };

  flake.modules.homeManager.desktop-hyprland-standalone = { pkgs, config, osConfig, ... }: let
  in {
    home.packages = with pkgs; [
      awww
      hyprshade
      brightnessctl

      bluez

      networkmanagerapplet

      xdg-user-dirs
    ];

    xdg.configFile."hypr/hyprland.lua".text = ''
      local home = os.getenv("HOME")
      package.path = package.path .. ";" .. home .. "/.config/hypr/?.lua"
      require("nixosConfig")
      require("lua.config")
    '';

    xdg.configFile."hypr/lua" = {
      source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.dotfiles/modules/features/desktop/hypr/hyprland/hypr/lua";
      recursive = true;
    };

    xdg.configFile."hypr/shaders" = {
      source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.dotfiles/modules/features/desktop/hypr/hyprland/hypr/shaders";
      recursive = true;
    };

    xdg.configFile."hypr/nixosConfig.lua".text =
      lib.concatStringsSep "\n" osConfig.configuration.hyprlandLua;


    xdg.configFile."hypr/plugins/hyprsplit".source = inputs.hyprsplit;
  };
}
