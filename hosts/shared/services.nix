{ pkgs, user, ... }:

{
  services = {
    fwupd.enable = true;
    fstrim.enable = true;
    udisks2.enable = true;
    flatpak.enable = true;
    openssh.enable = true;
    btrfs.autoScrub.enable = true;
    qemuGuest.enable = true;

    # dbus = {
    #   enable = true;
    #   packages = with pkgs; [dconf gcr];
    # };

    # gnome = {
    #   glib-networking.enable = true;
    #   gnome-keyring.enable = true;
    # };

    # gvfs.enable = true;

    xserver = {
      enable = true;
      layout = "us";
      # exportConfiguration = true;
      displayManager.gdm.enable = true;
      displayManager.autoLogin.enable = true;
      displayManager.autoLogin.user = "${user}";
      # windowManager.i3.enable = true;
    };

    # udev.packages = [pkgs.gnome.gnome-settings-daemon];
  };

  virtualisation = {
    docker = {
      enable = true;
      enableOnBoot = false;
    };

    libvirtd.enable = true;
  };
}
