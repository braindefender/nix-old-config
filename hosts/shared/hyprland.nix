{
  config,
  pkgs,
  ...
}: let
  exec = "exec Hyprland";
in {
  environment = {
    loginShellInit = ''
      if [ -z $DISPLAY ] && [ "$(tty)" = "/dev/tty1" ]; then
        ${exec}
      fi
    '';

    variables = {
      XDG_CURRENT_DESKTOP = "Hyprland";
      XDG_SESSION_DESKTOP = "Hyprland";
      XDG_SESSION_TYPE = "wayland";
    };

    sessionVariables = {
      GDK_BACKEND = "wayland";
      MOZ_ENABLE_WAYLAND = "1";
      WLR_NO_HARDWARE_CURSORS = "1";
    };

    systemPackages = with pkgs; [
      grim
      slurp
      swaybg
      swaylock
      wl-clipboard
      wlr-randr
    ];
  };

  programs.waybar.enable = true;

  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
    nvidiaPatches = true;
  };
}
