{ config, lib, modulesPath, ... }:

{
  imports = [ (modulesPath + "/installer/scan/not-detected.nix") ];

  boot = {
    initrd = {
      availableKernelModules = [ "xhci_pci" "ahci" "nvme" "usb_storage" "usbhid" "sd_mod" ];
      kernelModules = [ "nvidia" "nvidia_modeset" "nvidia_uvm" "nvidia_drm" ];
    };
    kernelModules = [ "kvm-intel" ];
    extraModulePackages = with config.boot.kernelPackages; [ ];
  };

  services.blueman.enable = true;

  networking.hostName = "terra-two";

  powerManagement.cpuFreqGovernor = lib.mkDefault "powersave";
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;


  fileSystems."/" =
    { device = "/dev/disk/by-uuid/1cd0a713-de1d-4287-b658-04b69a8f5490";
      fsType = "btrfs";
      options = [ "subvol=@" ];
    };

  fileSystems."/boot/efi" =
    { device = "/dev/disk/by-uuid/B510-A79C";
      fsType = "vfat";
    };

  swapDevices = [ ];

}
