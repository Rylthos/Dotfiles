{ self, ... }: {
  flake.modules.nixos.udev-teensy = { pkgs, ... }: {
    services.udev.packages = [
      (pkgs.writeTextFile {
          name = "teensy_udev";
          text = ''
              ATTRS{idVendor}=="16c0", ATTRS{idProduct}=="04*", ENV{ID_MM_DEVICE_IGNORE}="1", ENV{ID_MM_PORT_IGNORE}="1"
              ATTRS{idVendor}=="16c0", ATTRS{idProduct}=="04[789a]*", ENV{MTP_NO_PROBE}="1"
              KERNEL=="ttyACM*", ATTRS{idVendor}=="16c0", ATTRS{idProduct}=="04*", MODE:="0666", RUN:="/run/current-system/sw/bin/stty -F /dev/%k raw -echo"
              KERNEL=="hidraw*", ATTRS{idVendor}=="16c0", ATTRS{idProduct}=="04*", MODE:="0666"
              SUBSYSTEMS=="usb", ATTRS{idVendor}=="16c0", ATTRS{idProduct}=="04*", MODE:="0666"
              KERNEL=="hidraw*", ATTRS{idVendor}=="1fc9", ATTRS{idProduct}=="013*", MODE:="0666"
              SUBSYSTEMS=="usb", ATTRS{idVendor}=="1fc9", ATTRS{idProduct}=="013*", MODE:="0666"
          '';
          destination = "/etc/udev/rules.d/00-teensy.rules";
       })
    ];
  };
}
