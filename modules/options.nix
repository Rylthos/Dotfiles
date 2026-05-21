{ self, lib, pkgs, ... }: {
  options.configuration = {
    machine.hostname = lib.mkOption { type = lib.types.str; };

    machine.host = lib.mkOption {
      type = lib.types.enum [
        "vm"
        "desktop"
        "laptop"
      ];
    };

    user = lib.mkOption { type = lib.types.str; };

    muteOnLock = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "Whether to enable muteOnLock";
      example = true;
    };

    enableScreenRecorder = lib.mkOption {
      type = lib.types.bool;
      default = true;
    };

    dotfilesPath = lib.mkOption {
      type = lib.types.str;
      default = "/home/aaron/.dotfiles";
    };

    lockScript = lib.mkOption {
      type = lib.types.package;
      default = pkgs.writeShellScriptBin "lock" ''
        inotify "Unimplemented Lock script"
      '';
    };

    hyprlandLua = lib.mkOption {
      type = lib.types.listOf lib.types.lines;
      default = [];
    };
  };
}
