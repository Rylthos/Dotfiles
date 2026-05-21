{ self, ... }: {
  flake.modules.nixos.udev-picotools = { pkgs, ... }: {
    services.udev.packages = [
      (pkgs.writeTextFile {
          name = "picotootls";
          text = ''
            SUBSYSTEM=="usb", ATTRS{idVendor}=="2e8a", ATTRS{idProduct}=="0003", TAG+="uaccess", MODE="660", GROUP="plugdev"
            SUBSYSTEM=="usb", ATTRS{idVendor}=="2e8a", ATTRS{idProduct}=="0009", TAG+="uaccess", MODE="660", GROUP="plugdev"
            SUBSYSTEM=="usb", ATTRS{idVendor}=="2e8a", ATTRS{idProduct}=="000a", TAG+="uaccess", MODE="660", GROUP="plugdev"
            SUBSYSTEM=="usb", ATTRS{idVendor}=="2e8a", ATTRS{idProduct}=="000f", TAG+="uaccess", MODE="660", GROUP="plugdev"
          '';
          destination = "/etc/udev/rules.d/60-picotool.rules";
       })
    ];
  };
}
