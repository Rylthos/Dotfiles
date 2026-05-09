{ self, ... }: {
  flake.modules.nixos.user-aaron = { pkgs, ... }: {
    users.users.aaron = {
      isNormalUser = true;
      description = "Aaron Danton";
      extraGroups = [
        "networkmanager"
        "wheel"
        "render"
        "video"
        "dialout"
        "wireshark"
      ];
      shell = pkgs.zsh;
    };
  };
}
