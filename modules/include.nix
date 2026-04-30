{ inputs, lib, ... }: {
  flake.lib = {
    loadNixosAndHM =
    config: modules: username:
    assert builtins.isAttrs config;
    assert builtins.isList modules;
    assert builtins.isString username;
    let
      mapNixos = modules: (builtins.map (module: config.flake.modules.nixos.${module} or {}) modules);
      mapHM = modules: (builtins.map (module: config.flake.modules.homeManager.${module} or {}) modules);
    in {
      assertions = [
        {
          assertion = builtins.all (name: (config.flake.modules.nixos ? ${name}) || (config.flake.modules.homeManager ? ${name})) modules;
          message = let
            missingNames = builtins.filter (name: !((config.flake.modules.nixos ? ${name}) || (config.flake.modules.homeManager ? ${name}))) modules;
          in "Unknown modules: '${lib.concatStringsSep ", " missingNames}'";
        }
      ];
      imports = (mapNixos modules) ++ [
        {
          imports = [ inputs.home-manager.nixosModules.home-manager ];

          home-manager.users.${username}.imports = [
            (
             { osConfig, ... }: {
               home.stateVersion = "26.05";
             }
            )
          ] ++ (builtins.map (module: config.flake.modules.homeManager.${module} or {}) modules);
        }
      ];
    };
  };
}
