{ pkgs, lib, config, ... }:
    with lib;
    let cfg = config.modules.zsh;
in {
    options.modules.zsh = { enable = mkEnableOption "zsh"; };
    config = mkIf cfg.enable {

        programs.zsh = {
            enable = true;
            enableCompletion = true;
            autosuggestion = {
                enable = true;
                strategy = [ "match_prev_cmd" ];
            };
            syntaxHighlighting.enable = true;

            history = {
                share = true;
                size = 10000;
            };

            shellAliases = {
                ls = "eza --group-directories-first";
                ll = "ls -al";
                dotfiles = "cd $NIXOS_CONFIG_DIR";
                tmuxnv = "tmux new-session nvim";
                psst = "env -u WAYLAND_DISPLAY psst-gui";
                cat = "bat";
                t = "tmux";
                n = "nvim";
            };

            oh-my-zsh = {
                enable = true;
                plugins = [
                    "fzf"
                    "starship"
                    "direnv"
                ];

                theme = "robbyrussell";
            };
        };
    };
}
