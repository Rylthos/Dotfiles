{ self, ... }: {
  flake.modules.homeManager.desktop-packages = { pkgs, ... }: {
    home.packages = with pkgs; [
      arduino-ide
      libreoffice-qt
      vlc
      xournalpp
      xdg-utils

      kdePackages.okular
      zathura

      grim
      slurp

      wl-clipboard

      kdePackages.kate
      gparted

      qpwgraph

      kdePackages.ark

      # vesktop

      proton-vpn
    ];
  };
}
