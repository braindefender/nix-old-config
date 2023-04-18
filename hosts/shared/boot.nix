{ config, pkgs, ... }:

{
  boot = {
    loader = {
      timeout = 1;

      # Enable systemd-boot instead of GRUB
      systemd-boot = {
        enable = true;
	configurationLimit = 5;
      };

      efi = {
        canTouchEfiVariables = true;
        efiSysMountPoint = "/boot/efi";
      };
    };

    initrd.supportedFilesystems = [ "btrfs" ];
    initrd.systemd.enable = true;
    kernelPackages = pkgs.linuxPackages_latest;
    extraModulePackages = with config.boot.kernelPackages; [ ];
  };
}
