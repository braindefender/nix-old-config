{pkgs, ...}: {
  imports = [
    ./qtile.nix
    # ./i3.nix
  ];

  services.xserver = {
    enable = true;
  };

  environment.systemPackages = with pkgs; [
    xorg.xkbcomp
    xorg.xmodmap
  ];


  xdg.portal = {
    enable = true;
    extraPortals = [pkgs.xdg-desktop-portal-gtk];
  };
}
