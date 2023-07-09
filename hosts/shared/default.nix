{
  lib,
  pkgs,
  home-manager,
  inputs,
  outputs,
  user,
  ...
}: {
  imports = [
    inputs.home-manager.nixosModules.home-manager
    ./env.nix
    ./base.nix
    ./boot.nix
    ./users.nix
    ./fonts.nix
    ./locale.nix
    ./packages.nix
    ./programs.nix
    ./security.nix
    ./services.nix
    ./pipewire.nix
    ./keyboard.nix
    ./universal.nix
    # ./hyprland.nix
    ./i3.nix
  ];

  # Default network settings. DHCP and Network Manager.
  networking = {
    useDHCP = lib.mkDefault true;
    networkmanager.enable = true;
  };

  # Enable power management TODO: Check
  powerManagement.cpuFreqGovernor = lib.mkDefault "powersave";

  # hardware = {
  # enableRedistributableFirmware = true;

  # opengl = {
  #   enable = true;
  #   driSupport = true;
  #   driSupport32Bit = true;
  #   # TODO: Check that extraPackages are needed?
  # };
  # };

  xdg.portal = {
    enable = true;
    extraPortals = [pkgs.xdg-desktop-portal-gtk];
  };
}
