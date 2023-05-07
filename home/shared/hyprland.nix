{
  config,
  pkgs,
  ...
}: let
  execute = ''
    exec-once=dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP
    exec-once=${pkgs.waybar}/bin/waybar
    exec-once=${pkgs.swww}/bin/swww init
    exec-once=${pkgs.swww}/bin/swww img ${config.xdg.configHome}/wall
  '';

  bindings = ''
    bindm = SUPER, mouse:272, movewindow
    bindm = SUPER, mouse:273, resizewindow

    bind = SUPER,left,movefocus,l
    bind = SUPER,down,movefocus,d
    bind = SUPER,up,movefocus,u
    bind = SUPER,right,movefocus,r

    bindl=CTRL_SUPER,left,workspace,-1
    bindl=CTRL_SUPER,right,workspace,+1

    bind = CTRLSHIFT,left,movetoworkspace,-1
    bind = CTRLSHIFT,right,movetoworkspace,+1

    bind = SUPER,Return,exec,${pkgs.kitty}/bin/kitty
    bind = SUPER,Escape,exit,
    bind = SUPER,Q,killactive,
    bind = SUPER,L,exec,${pkgs.swaylock}/bin/swaylock
    bind = SUPER,E,exec,${pkgs.pcmanfm}/bin/pcmanfm
    bind = SUPER,H,togglefloating,
    bind = SUPER,Space,exec,${pkgs.wofi}/bin/wofi --show drun
    bind = SUPER,F,fullscreen,
    bind = SUPER,R,togglesplit,
    bind = SUPERSHIFT,F,forcerendererreload,
    bind = SUPERSHIFT,R,exec,${pkgs.hyprland}/bin/hyprctl reload
  '';

  windowRules = ''
    windowrule = float,title:^(Volume Control)$
    windowrule = float,title:^(Picture-in-Picture)$
    windowrule = pin,title:^(Picture-in-Picture)$
    windowrule = move 75% 75% ,title:^(Picture-in-Picture)$
    windowrule = size 24% 24% ,title:^(Picture-in-Picture)$
    windowrule = float,title:^(Media viewer)$
    windowrulev2 = float,class:^(code)$,title:^(Open File)$
  '';

  hyprlandConf = ''
    general {
      border_size = 2
      gaps_in = 4
      gaps_out = 8
      layout = master
    }

    decoration {
      rounding = 8
      multisample_edges = true
      fullscreen_opacity = 1
      inactive_opacity = 0.9
      active_opacity = 1
      drop_shadow = false
      blur = true
      blur_new_optimizations = true
    }

    animations {
      enabled = true

      bezier = myBezier, 0.05, 0.9, 0.1, 1.05

      animation = windows, 1, 7, myBezier
      animation = windowsOut, 1, 7, default, popin 80%
      animation = border, 1, 10, default
      animation = borderangle, 1, 8, default
      animation = fade, 1, 7, default
      animation = workspaces, 1, 6, default
    }

    input {
      sensitivity = 0
      follow_mouse = 2
      repeat_delay = 250
      accel_profile = flat
      numlock_by_default = 1
      kb_file = ${config.xdg.configHome}/xkb/symbols/octopus
    }

    dwindle {
      pseudotile = true
      preserve_split = true
    }

    master {
      new_is_master = false
      mfact = 0.66
    }

    monitor=,3440x1440@120,0x0,1

    ${execute}
    ${bindings}
    ${windowRules}
  '';
in {
  xdg.configFile."hypr/hyprland.conf".text = hyprlandConf;

  programs.swaylock.settings = {
    #image = "$HOME/.config/wall";
    color = "000000f0";
    font-size = "24";
    indicator-idle-visible = false;
    indicator-radius = 100;
    indicator-thickness = 20;
    inside-color = "00000000";
    inside-clear-color = "00000000";
    inside-ver-color = "00000000";
    inside-wrong-color = "00000000";
    key-hl-color = "79b360";
    line-color = "000000f0";
    line-clear-color = "000000f0";
    line-ver-color = "000000f0";
    line-wrong-color = "000000f0";
    ring-color = "ffffff50";
    ring-clear-color = "bbbbbb50";
    ring-ver-color = "bbbbbb50";
    ring-wrong-color = "b3606050";
    text-color = "ffffff";
    text-ver-color = "ffffff";
    text-wrong-color = "ffffff";
    show-failed-attempts = true;
  };
}
