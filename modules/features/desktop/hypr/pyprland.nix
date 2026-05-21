{ self, inputs, config, lib, ... }: {
  flake.modules.nixos.desktop-pyprland = { config, ... }: {
    config.configuration.hyprlandLua = lib.mkAfter [
      "hl.on('hyprland.start', function() hl.exec_cmd('pypr') end)"
      "hl.bind('SUPER + T', hl.dsp.exec_cmd('pypr toggle term'))"
      "hl.bind('SUPER + C', hl.dsp.exec_cmd('pypr toggle calc'))"
    ];
  };

  flake.modules.homeManager.desktop-pyprland = { pkgs, ... }: {
    home.packages = [
      inputs.pyprland.packages.x86_64-linux.pyprland
    ];

    xdg.configFile."pypr/config.toml".source = (pkgs.formats.toml {}).generate "pypr_config" {
      pyprland = {
        plugins = [
          "scratchpads"
        ];
      };

      scratchpads = {
        term = {
          animation = "fromTop";
          command = "alacritty --class Alacritty-dropdown-term";
          class = "Alacritty-dropdown-term";
          size = "75% 60%";
          max_size = "1920px 100%";
          margin = 50;
          unfocus = "hide";
          hysteresis = 0.4;
          lazy = true;
        };

        calc = {
          animation = "fromRight";
          command = "alacritty --class octave-calculator -e octave -q";
          class = "octave-calculator";
          size = "30% 50%";
          max_size = "1920px 100%";
          margin = 50;
          hysteresis = 0.4;
          lazy = true;
        };
      };
    };
  };
}
