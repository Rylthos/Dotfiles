{ self, ... }: {
  flake.modules.nixos.desktop-hardware = { config, lib, modulesPath, ... }: {
    imports = [
      ./_filesystem.nix
      (modulesPath + "/installer/scan/not-detected.nix")
    ];

    boot.initrd.availableKernelModules = [ "xhci_pci" "ahci" "nvme" "usbhid" "usb_storage" "sd_mod" "sr_mod" ];
    boot.initrd.kernelModules = [ ];
    boot.kernelModules = [ "kvm-intel" "nvidia" "nvidia_modeset" "nvidia_drm" "nvidia_uvm" ];
    boot.extraModulePackages = [ ];

    networking.useDHCP = lib.mkDefault true;

    nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
    hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
  };
}
