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
    ./locale.nix
    ./packages.nix
    ./programs.nix
    ./security.nix
    ./services.nix
    ./pipewire.nix
    ./hyprland.nix
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
    extraPortals = [pkgs.xdg-desktop-portal-hyprland];
  };

  # TODO: Move to a separate file
  fonts = {
    fonts = with pkgs; [
      corefonts # MS Windows Fonts
      cantarell-fonts # GNOME 3 Default Font
      noto-fonts
      noto-fonts-emoji
      font-awesome
      (nerdfonts.override {
        fonts = ["CascadiaCode" "FiraCode" "JetBrainsMono"];
      })
    ];

    fontconfig = {
      enable = true;
      antialias = true;
      hinting = {
        enable = true;
        autohint = true;
        style = "hintfull";
      };

      defaultFonts = {
        emoji = ["Segoe UI Emoji" "Noto Fonts Emoji"];
      };

      subpixel.lcdfilter = "default";
    };
  };
}
