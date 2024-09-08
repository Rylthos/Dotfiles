{ config, lib, inputs, ... }:
{
    imports = [ ../../modules/default.nix ];
    config.modules = {
      alacritty.enable = true;
        direnv.enable = true;
        firefox.enable = true;
        fish.enable = true;
        git.enable = true;
        gui_packages.enable = true;
        hyprland.enable = true;
        mako.enable = true;
        neovim.enable = true;
        packages.enable = true;
        python.enable = true;
        spotify_player.enable = true;
        theme.enable = true;
        tmux.enable = true;
        waybar.enable = true;
        wlogout.enable = true;
        wofi.enable = true;
    };

    config.programs.fish.shellAliases = {
        coding = "cd $CODING";
        work = "cd $CAMBRIDGE_WORK";
        supo = "cd $CAMBRIDGE_SUPO";
    };
}
