{ ... }:

{
  security = {
    pam.services = {
      login.enableGnomeKeyring = true;
      lightdm.enableGnomeKeyring = true;
    };

    rtkit.enable = true;
    polkit.enable = true;

    # Disable password for sudo
    sudo.wheelNeedsPassword = false;
  };
}
