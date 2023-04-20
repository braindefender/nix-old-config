{
  config,
  pkgs,
  ...
}: {
  environment.systemPackages = with pkgs; [
    # Terminal
    kitty
    kitty-themes

    # Browsers
    firefox
    google-chrome

    # Messengers
    # zoom-us
    tdesktop
    discord-canary

    # Media Viewers
    feh
    mpv
    vlc
    gimp
    # zathura

    # GUI Utilities
    # blueman
    # galculator
    gparted
    virt-manager
    pcmanfm

    # CLI Utilities
    ## Sound
    alsa-lib
    alsa-plugins
    alsa-tools
    alsa-utils
    pamixer
    playerctl
    pavucontrol
    ## Filesystem
    efibootmgr
    efitools
    ntfs3g
    exfatprogs
    btrfs-progs
    ## File Management
    zip
    p7zip
    unzip
    unrar
    rsync
    ## Others
    zsh
    bat
    exa
    fzf
    git
    btop
    curl
    wget
    neovim
    ripgrep
    usbutils
    pciutils
    smartmontools
    wirelesstools

    # Core Libraries
    acpi
    dbus
    dconf
    ffmpeg-full
    gcc
    glib
    imagemagick
    libappindicator
    libnotify
    libsecret
    librsvg
    libtool
    libva
    libva-utils
    pulseaudio
    zlib
  ];
}
