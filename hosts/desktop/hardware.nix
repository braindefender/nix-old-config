{ config, lib, pkgs, ... }:

{
  boot = {
    # Before boot
    initrd = {
      kernelModules = [ "nvidia" "nvidia_modeset" "nvidia_uvm" "nvidia_drm" ];
      availableKernelModules = [ "xhci_pci" "ahci" "nvme" "usb_storage" "usbhid" "sd_mod" ];
    };

    # After boot
    kernelModules = [ "kvm-intel" ];
  };

  # Enable NVidia drivers for X
  services.xserver.videoDrivers = [ "nvidia" ];

  # TODO: Check
  hardware.nvidia.modesetting.enable = true;

  # Enable Bluetooth service
  services.blueman.enable = true;

  # Define hostname
  networking.hostName = "brain-desk";

  # Enable Intel microcode
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
