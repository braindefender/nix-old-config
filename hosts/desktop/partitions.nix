{config, ...}:
let
  # Define OS partition label
  label = "NIX";

  btrfs = [
    "space_cache=v2"
    "compress=zstd:2"
    "discard=async"
    "noatime"
    "ssd"
  ];
in
{
  fileSystems = {
    "/" = {
      device = "/dev/disk/by-uuid/1cd0a713-de1d-4287-b658-04b69a8f5490";
      fsType = "btrfs";
      options = [ "subvol=@" ];
    };
    #"/" = {
    #  device = "/dev/disk/by-label/${label}";
    #  fsType = "btrfs";
    #  options = btrfs ++ [ "subvol=root" ];
    #};

    #"/home" = {
    #  device = "/dev/disk/by-label/${label}";
    #  fsType = "btrfs";
    #  options = btrfs ++ [ "subvol=home" ];
    #};

    #"/nix" = {
    #  device = "/dev/disk/by-label/${label}";
    #  fsType = "btrfs";
    #  options = btrfs ++ [ "subvol=nix" ];
    #};

    #"/log" = {
    #  device = "/dev/disk/by-label/${label}";
    #  fsType = "btrfs";
    #  options = btrfs ++ [ "subvol=log" ];
    #  neededForBoot = true;
    #};

    ${config.boot.loader.efi.efiSysMountPoint} = {
      device = "/dev/disk/by-uuid/B510-A79C";
      # device = "/dev/disk/by-label/EFI";
      fsType = "vfat";
    };
  };

  #swapDevices = [ { device = "/dev/disk/by-label/SWP"; } ];
  swapDevices = [  ];
}
