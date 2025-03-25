{
    description = "NixOS Configuration";

    inputs = {
        nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
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
    };

    outputs = { home-manager, nixpkgs, nix-colors, nixos-wsl, ... }@inputs:
        let
            system = "x86_64-linux";
            pkgs = inputs.nixpkgs.legacyPackages.${system};
            lib = nixpkgs.lib;

            mkSystem = pkgs: system: hostname: wsl:
                pkgs.lib.nixosSystem {
                    system = system;
                    modules = [
                        ./modules/system/configuration.nix
                        (./. + "/hosts/${hostname}/system.nix")
                        (./. + "/hosts/${hostname}/hardware-configuration.nix")
                        home-manager.nixosModules.home-manager
                        {
                            home-manager = {
                                useUserPackages = true;
                                useGlobalPkgs = true;
                                extraSpecialArgs = { inherit inputs; inherit nix-colors; inherit nixpkgs; };
                                users.aaron = (./. + "/hosts/${hostname}/user.nix");
                            };
                        }

                    ] ++ (lib.optionals (wsl) [
                        nixos-wsl.nixosModules.default
                        {
                            wsl.enable = true;
                        }
                    ]);
                };
        in {
            nixosConfigurations = {
                laptop = mkSystem inputs.nixpkgs "x86_64-linux" "laptop" false;
                wsl = mkSystem inputs.nixpkgs "x86_64-linux" "wsl" true;
        };
    };
}
