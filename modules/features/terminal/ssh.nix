{ self, ... }: {
  flake.modules.nixos.terminal-ssh = { ... }: {
    programs.mosh.enable = true;
  };

  flake.modules.homeManager.terminal-ssh = { ... }: {

    programs.ssh = {
      enable = true;
      enableDefaultConfig = false;
      matchBlocks = {
        "github.com" = {
          identityFile = "~/.ssh/id_github";
          addKeysToAgent = "yes";
          hostname = "github.com";
          host = "github.com";
          user = "git";
          identitiesOnly = true;
        };
        "github-cam" = {
          identityFile = "~/.ssh/id_github_cam";
          addKeysToAgent = "yes";
          hostname = "github.com";
          host = "github-cam";
          user = "git";
          identitiesOnly = true;
        };
        "gitlab.com" = {
          identityFile = "~/.ssh/id_gitlab_cam";
          addKeysToAgent = "yes";
          hostname = "gitlab.com";
          host = "gitlab.com";
          user = "git";
          identitiesOnly = true;
        };
      };
    };
  };
}
