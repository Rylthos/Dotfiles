{ self, ... }: {
  flake.modules.nixos.laptop-hardware = { config, lib, modulesPath, ... }: {
    imports = [
      ./_filesystem.nix
      (modulesPath + "/installer/scan/not-detected.nix")
    ];

    boot.initrd.availableKernelModules = [ "nvme" "xhci_pci" "usb_storage" "sd_mod" "rtsx_pci_sdmmc" ];
    boot.initrd.kernelModules = [ "amdgpu" ];
    boot.kernelModules = [ "kvm-amd" "video=eDP-1:2880x1800@90" ];
    boot.extraModulePackages = [ ];
    boot.kernelParams = [ "kvm.enable_virt_at_load=0" ];

    networking.useDHCP = lib.mkDefault true;

    nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
    hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
  };
}
