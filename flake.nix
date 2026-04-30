{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    flake-parts.url = "github:hercules-ci/flake-parts";
    import-tree.url = "github:vic/import-tree";

    nix-colors.url = "github:misterio77/nix-colors";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hyprland.url = "github:hyprwm/Hyprland/v0.53.0?submodules=1";
    hy3 = {
      url = "github:outfoxxed/hy3/hl0.53.0";
      inputs.hyprland.follows = "hyprland";
    };
    hyprsplit = {
      url = "github:shezdy/hyprsplit/v0.53.0";
      inputs.hyprland.follows = "hyprland";
    };
  };

  outputs = inputs: inputs.flake-parts.lib.mkFlake
    { inherit inputs; }
    (inputs.import-tree ./modules);
}
