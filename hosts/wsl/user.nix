{ config, lib, inputs, ... }:
{
    imports = [ ../../modules/default.nix ];
    config.modules = {
        direnv.enable = true;
        fish.enable = true;
        git.enable = true;
        neovim.enable = true;
        packages.enable = true;
        python.enable = true;
        theme.enable = true;
        tmux.enable = true;
    };

    config.programs.fish.shellAliases = {
        coding = "cd $CODING";
    };
}
