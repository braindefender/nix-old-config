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
    ./nixos.nix

    # XServer configuration and window managers
    # ./xserver

    # Wayland configuration and window managers
    ./wayland

    # Common system configuration
    ./common

    ./env.nix
    ./users.nix
    ./fonts.nix
    ./locale.nix
    ./packages.nix
    ./programs.nix
    ./security.nix
    ./services.nix
    ./pipewire.nix
  ];

  # Default network settings. DHCP and Network Manager.
  networking = {
    useDHCP = lib.mkDefault true;
    networkmanager.enable = true;
  };

  # Enable power management TODO: Check
  powerManagement.cpuFreqGovernor = lib.mkDefault "powersave";
}
