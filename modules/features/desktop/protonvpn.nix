{ self, ... }: {
  flake.modules.nixos.desktop-protonvpn = { pkgs, ... }: {
    security.pam.services = {
      aaron.kwallet = {
        enable = true;
        package = pkgs.kdePackages.kwallet-pam;
      };
    };
  };

  flake.modules.homeManager.desktop-protonvpn = { pkgs, ... }: {
    home.packages = with pkgs; [
      proton-vpn-cli
      proton-vpn

      kdePackages.kwallet
      kdePackages.kwalletmanager
    ];
  };
}
