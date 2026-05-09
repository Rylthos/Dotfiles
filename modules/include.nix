{ inputs, lib, ... }: {
  flake.lib = rec {
    loadNixosAndHM =
      config: modules: username:
      assert builtins.isAttrs config;
      assert builtins.isList modules;
      assert builtins.isString username;
      let
        invalidNames = builtins.filter (name: !((config.flake.modules.nixos ? ${name}) || (config.flake.modules.homeManager ? ${name}))) modules;
      in
      assert lib.assertMsg (invalidNames == []) "Unknown modules ${lib.concatStringsSep ", " invalidNames}";
      let
        mapNixos = modules: (map (module: config.flake.modules.nixos.${module} or {}) modules);
        mapHM = modules: (map (module: config.flake.modules.homeManager.${module} or {}) modules);
      in {
        imports = (mapNixos modules) ++ [
          {
            imports = [
              inputs.home-manager.nixosModules.home-manager
              ./options.nix
            ];

            home-manager.backupFileExtension = "backup";

            home-manager = {
              extraSpecialArgs = {
                inherit inputs;
                pkgsStable = import inputs.nixpkgs-stable {
                  system = "x86_64-linux";
                  config.allowUnfree = true;
                };
              };
              users.${username} = {
                imports = [
                  ({ ... }: { home.stateVersion = "26.05"; })
                    ({ ... }: { nixpkgs.config.allowUnfree = true; })
                ] ++ (mapHM modules);
              };
            };
          }
        ];
      };

    findPackages =
      config: modules: target:
      assert builtins.isAttrs config;
      assert builtins.isList modules;
      assert builtins.isString target;
      let
        invalidNames = builtins.filter (name: !((config.flake.modules.nixos ? ${name}) || (config.flake.modules.homeManager ? ${name}))) modules;
      in
      assert lib.assertMsg (invalidNames == []) "Unknown modules ${lib.concatStringsSep ", " invalidNames}";
      map (module: config.flake.modules.${target}.${module} or {}) modules;

    groupPackages =
      config: modules: name:
      assert builtins.isAttrs config;
      assert builtins.isList modules;
      assert builtins.isString name;
      {
        nixos.${name} = { ... }: {
          imports = findPackages config modules "nixos";
        };

        homeManager.${name} = { ... }: {
          imports = findPackages config modules "homeManager";
        };
      };

  };
}
