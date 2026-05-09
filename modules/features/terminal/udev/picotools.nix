{ self, ... }: {
  flake.modules.nixos.udev-picotools = { pkgs, ... }: {
    services.udev.packages = [
      (pkgs.writeTextFile {
          name = "picotootls";
          text = ''
              SUBSYSTEM=="usb", ATTRS{idVendor}=="2e8a", ATTRS{idProduct}=="0003", MODE="660", GROUP="plugdev"
              SUBSYSTEM=="usb", ATTRS{idVendor}=="2e8a", ATTRS{idProduct}=="000a", MODE="660", GROUP="plugdev"
          '';
          destination = "/etc/udev/rules.d/90-picotools.rules";
       })
    ];
  };
}
