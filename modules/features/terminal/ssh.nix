{ self, ... }: {
  flake.modules.nixos.terminal-ssh = { ... }: {
    programs.mosh.enable = true;
  };

  flake.modules.homeManager.terminal-ssh = { ... }: {

    programs.ssh = {
      enable = true;
      enableDefaultConfig = false;
      settings = {
        "github.com" = {
          identityFile = "~/.ssh/id_github";
          addKeysToAgent = "yes";
          hostname = "github.com";
          host = "github.com";
          user = "git";
          identitiesOnly = true;
        };
      };
    };
  };
}
