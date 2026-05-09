{ self, ... }: {
  flake.modules.homeManager.gaming-prismlauncher = { pkgs, ... }: {
    home.packages = with pkgs; [
      prismlauncher
    ];
  };
}
