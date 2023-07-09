{
  config,
  pkgs,
  ...
}: {
  services.xserver = {
    enable = true;

    desktopManager = {
      xterm.enable = false;
    };

    displayManager = {
      defaultSession = "none+i3";
    };

    windowManager.i3 = {
      enable = true;
      package = pkgs.i3-rounded;
      extraPackages = with pkgs; [
        rofi
        xorg.xkbcomp
        xorg.xmodmap
      ];
    };
  };
}
