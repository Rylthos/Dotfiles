{ ... }: {
  flake.modules.nixos.base-boot = { ... }: {
    boot = {
        kernel.sysctl = {
            "kernel.printk" = "3 3 3 3";
        };
        tmp.cleanOnBoot = true;
        loader = {
            systemd-boot.enable = true;
            systemd-boot.editor = false;
            systemd-boot.configurationLimit = 5;
            efi.canTouchEfiVariables = true;
        };
    };
  };
}
