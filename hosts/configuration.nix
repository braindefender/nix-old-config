{ config, lib, pkgs, inputs, user, name, ... }:

{
  imports = (import ../modules/shell);
  
  time.timeZone = "Asia/Novosibirsk";

  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "ru_RU.UTF-8";
    LC_IDENTIFICATION = "ru_RU.UTF-8";
    LC_MEASUREMENT = "ru_RU.UTF-8";
    LC_MONETARY = "ru_RU.UTF-8";
    LC_NAME = "ru_RU.UTF-8";
    LC_NUMERIC = "ru_RU.UTF-8";
    LC_PAPER = "ru_RU.UTF-8";
    LC_TELEPHONE = "ru_RU.UTF-8";
    LC_TIME = "ru_RU.UTF-8";
  };

  xdg.portal = {
    enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  };

  users.users.${user} = {
    isNormalUser = true;
    shell = pkgs.zsh;
    description = "${name}";
    extraGroups = [ "wheel" "video" "audio" "camera" "networkmanager" "kvm" "libvirtd" ];
    initialPassword = "password";
  };

  security = {
    sudo.wheelNeedsPassword = false;
    rtkit.enable = true; # for PipeWire?
  };

  system = {
    autoUpgrade = {
      enable = true;
      channel = "https://nixos.org/channels/nixos-unstable";
    };
    stateVersion = "22.11";
  };

  nix = {
    settings = {
      auto-optimise-store = true;
    };
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };
    package = pkgs.nixFlakes;
    registry.nixpkgs.flake = inputs.nixpkgs;
    extraOptions = ''
      experimental-features = nix-command flakes
      keep-outputs          = true
      keep-derivations      = true
    '';
  };

  services = {
    flatpak.enable = true;
    openssh.enable = true;
    xserver = {
      enable = true;
      layout = "us";
      displayManager.gdm.enable = true;
      displayManager.autoLogin.enable = true;
      displayManager.autoLogin.user = "${user}";
      windowManager.i3.enable = true;
      videoDrivers = [ "nvidia" ];
    };
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };
  };

  # TODO: move to hardware-config
  sound.enable = true;
  hardware.pulseaudio.enable = false;

  environment = {
    variables = {
      TERMINAL = "kitty";
      EDITOR = "nvim";
      VISUAL = "nvim";
    };
    systemPackages = with pkgs; [
      curl
      wget
      git
      vim
      neovim
      # terminal
      kitty
      kitty-themes
      exa
      bat
      # browser
      firefox
      google-chrome
      # utility
      usbutils
      pciutils
    ];
  };

  fonts.fonts = with pkgs; [
    font-awesome
    corefonts
    (nerdfonts.override {
      fonts = ["FiraCode"];
    })
  ];

  nixpkgs.config.allowUnfree = true;
}
