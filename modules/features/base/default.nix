{ self, config, ... }: let
  modules = [
      "base-bluetooth"
      "base-boot"
      "base-environment"
      "base-firewall"
      "base-fonts"
      "base-hardware"
      "base-locale"
      "base-network"
      "base-nix-ld"
      "base-nix"
      "base-pipewire"
      "base-security"
      "base-services"
      "base-ssh"
      "base-system"
  ];
in {
  flake.modules = self.lib.groupPackages config modules "base";
}
