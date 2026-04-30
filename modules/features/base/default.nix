{ self, config, ... }: {
  flake.modules.nixos.base = { ... }: {
    imports = with self.modules.nixos; [
      base-bluetooth
      base-boot
      base-environment
      base-firewall
      base-fonts
      base-locale
      base-nix
      base-pipewire
      base-security
      base-ssh
      base-system
    ];
  };
}
