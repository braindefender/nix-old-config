{
  config,
  pkgs,
  ...
}: {
  boot = {
    loader = {
      timeout = 2;

      # Enable systemd-boot instead of GRUB
      systemd-boot = {
        enable = true;
        configurationLimit = 15;
      };

      efi = {
        canTouchEfiVariables = true;
        efiSysMountPoint = "/boot/efi";
      };
    };

    initrd.supportedFilesystems = ["btrfs"];
    initrd.systemd.enable = true;
    kernelPackages = pkgs.linuxPackages_latest;
    extraModulePackages = with config.boot.kernelPackages; [];
  };
}
