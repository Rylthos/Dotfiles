{ config, lib, inputs, ... }:
{
    imports = [ ../../modules/default.nix ];
    config.modules = {
        dev_packages.enable = true;
        direnv.enable = true;
        fish.enable = true;
        git.enable = true;
        keyboard.enable = true;
        neovim.enable = true;
        packages.enable = true;
        python.enable = true;
        spotify_player.enable = true;
        theme.enable = true;
        tmux.enable = true;
    };

    config.programs.fish.shellAliases = {
        coding = "cd $CODING";
    };
}
