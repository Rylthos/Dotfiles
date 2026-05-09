{
  fileSystems."/" = {
    device = "/dev/disk/by-uuid/74978927-5b39-4716-aa10-b2cb4ac56cdc";
    fsType = "btrfs";
    options = [ "subvol=@" ];
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/4AFA-9D2E";
    fsType = "vfat";
    options = [ "fmask=0077" "dmask=0077" ];
  };

  fileSystems."/mnt/data_hdd" = {
    device = "/dev/disk/by-id/ata-ST2000DX002-2DV164_Z4ZB6SHZ-part1";
    fsType = "btrfs";
    options = [
      "users"
      "exec"
    ];
  };

  fileSystems."/mnt/ssd" = {
    device = "/dev/disk/by-id/ata-Samsung_SSD_870_QVO_1TB_S5SVNF0R414404A-part1";
    fsType = "btrfs";
    options = [
      "users"
      "exec"
    ];
  };

  fileSystems."/mnt/game_hdd" = {
    device = "/dev/disk/by-uuid/0A5CD26F5CD25553";
    fsType = "ntfs";
    options = [
      "users"
      "exec"
    ];
  };

  fileSystems."/mnt/temp" = {
    device = "/dev/disk/by-uuid/da6a9d2e-adde-4ad1-832d-eaea5e9a8f30";
    fsType = "ext4";
    options = [
      "users"
      "exec"
      "rw"
    ];
  };

  swapDevices = [
    { device = "/dev/disk/by-uuid/94c20b7d-0d46-40fc-aae1-6fbb897c11be"; }
  ];
}
