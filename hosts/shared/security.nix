{ ... }:

{
  security = {
    pam.services = {
      gdm.enableGnomeKeyring = true;
      login.enableGnomeKeyring = true;
    };

    rtkit.enable = true;
    polkit.enable = true;

    # Disable password for sudo
    sudo.wheelNeedsPassword = false;
  };
}
