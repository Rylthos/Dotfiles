{
    description = "NixOS Configuration";

    inputs = {
        nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

        nixpkgs-stable.url = "github:NixOS/nixpkgs/nixos-25.05";
        home-manager = {
            url = "github:nix-community/home-manager";
            inputs.nixpkgs.follows = "nixpkgs";
        };

        nix-colors.url = "github:misterio77/nix-colors";
        nixos-wsl.url = "github:nix-community/NixOS-WSL/main";
        spicetify-nix = {
            url = "github:Gerg-L/spicetify-nix";
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

    outputs = { home-manager, nixpkgs, nixpkgs-stable, nix-colors, nixos-wsl, ... }@inputs:
        let
            mkSystem = pkgs: hostname: wsl:
                pkgs.lib.nixosSystem {
                    system = "x86_64-linux";
                    specialArgs = {
                        hostname = hostname;
                    };
                    modules = [
                        (./modules/system/configuration.nix)
                        (./. + "/hosts/${hostname}/system.nix")
                        (./. + "/hosts/${hostname}/hardware-configuration.nix")
                        home-manager.nixosModules.home-manager
                        {
                            home-manager = {
                                useUserPackages = true;
                                useGlobalPkgs = true;
                                extraSpecialArgs = {
                                    inherit inputs;
                                    inherit nix-colors;
                                    inherit nixpkgs;
                                    hostname = hostname;
                                    pkgs-stable = import nixpkgs-stable {
                                        system = "${pkgs.stdenv.hostPlatform.system}";
                                    };
                                };
                                users.aaron = (./. + "/hosts/${hostname}/user.nix");
                            };
                        }

                    ] ++ (nixpkgs.lib.optionals (wsl) [
                        nixos-wsl.nixosModules.default
                        {
                            wsl.enable = true;
                        }
                    ]);
                };
        in {
            nixosConfigurations = {
                laptop = mkSystem inputs.nixpkgs "laptop" false;
                wsl = mkSystem inputs.nixpkgs "wsl" true;
                desktop = mkSystem inputs.nixpkgs "desktop" false;
        };
    };
}
