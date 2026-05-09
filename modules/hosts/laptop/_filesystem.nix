{
  fileSystems."/" =
    { device = "/dev/disk/by-uuid/15854cca-4399-4546-ade5-0a467578b0bd";
      fsType = "ext4";
      options = [ "noatime" "nodiratime" "discard" ];
    };

  fileSystems."/boot" =
    { device = "/dev/disk/by-uuid/229A-96AF";
      fsType = "vfat";
    };

  swapDevices = [
    {
      device = "/var/lib/swapfile";
      size = 16 * 1024;
    }
  ];
}
