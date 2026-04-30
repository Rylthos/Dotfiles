{ inputs, ... }: {
  flake.lib = {
    loadNixosAndHM =
    config: modules: username:
    assert builtins.isAttrs config;
    assert builtins.isList modules;
    assert builtins.isString username;
    {
      imports = (builtins.map (module: config.flake.modules.nixos.${module} or {}) modules) ++ [
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
