{ self, ... }: {
  flake.modules.homeManager.terminal-yazi = { ... }: {
    programs.yazi = {
      enable = true;
      shellWrapperName = "y";
    };
  };
}
