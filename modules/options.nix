{ self, lib, ... }: {
  options.configuration = {
    machine.hostname = lib.mkOption { type = lib.types.str; };

    machine.host = lib.mkOption {
      type = lib.types.enum [
        "vm"
      ];
    };
  };
}
