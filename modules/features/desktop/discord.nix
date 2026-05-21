{ self, ... }: {
  flake.modules.homeManager.desktop-discord = { ... }: {
    programs.vesktop = {
      enable = true;

      vencord.settings = {
        autoUpdate = true;
        autoUpdateNotification = true;
        notifyAboutUpdates = true;
      };
    };
  };
}
