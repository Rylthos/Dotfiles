{ self, ... }: {
  flake.modules.homeManager.terminal-fastfetch = { pkgs, ... }: {
    programs.fastfetch = {
      enable = true;
    };
  };
}
