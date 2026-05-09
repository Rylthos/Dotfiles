{ self, ... }: {
  flake.modules.nixos.desktop-wireshark = { ... }: {
    programs.wireshark.enable = true;
  };
}
