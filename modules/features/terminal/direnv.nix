{ self, lib, ... }: {
  flake.modules.homeManager.terminal-direnv = { pkgs, ... }: {
    home.packages = with pkgs; [
      direnv
    ];

    programs.direnv = {
      enable = true;
      nix-direnv.enable = true;
      enableBashIntegration = true;
    };

    programs.fish = {
      interactiveShellInit = lib.mkAfter "direnv hook fish | source\n";
    };
  };
}
