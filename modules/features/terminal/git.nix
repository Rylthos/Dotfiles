{ self, ... }: {
  flake.modules.homeManager.terminal-git = { pkgs, ... }: {
    home.packages = with pkgs; [
      lazygit
    ];

    programs.git = {
      enable = true;
      signing.format = "openpgp";
      settings = {
        user = {
          name = "Aaron Danton";
          email = "aarondanton04@hotmail.com";
        };
        init = { defaultBranch = "main"; };
        core = {
          excludesfile = "$NIXOS_CONFIG_DIR/scripts/gitignore";
        };
      };
    };

    programs.zsh = {
      shellAliases = {
        gs = "git status";
        gl = "git log";
        glo = "git log --oneline";
        ga = "git add";
        gc = "git commit";
      };
    };
  };
}
