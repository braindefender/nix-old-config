{pkgs, ...}: let
  execute = ''
    exec-once=${pkgs.waybar}/bin/waybar
    exec-once=${pkgs.swaybg}/bin/swaybg
  '';

  bindings = ''
    bindm=SUPER,mouse:272,movewindow
    bindm=SUPER,mouse:273,resizewindow

    bind=SUPER,left,movefocus,l
    bind=SUPER,down,movefocus,d
    bind=SUPER,up,movefocus,u
    bind=SUPER,right,movefocus,r

    bindl=CTRL_SUPER,left,workspace,-1
    bindl=CTRL_SUPER,right,workspace,+1

    bind=CTRLSHIFT,left,movetoworkspace,-1
    bind=CTRLSHIFT,right,movetoworkspace,+1

    bind=SUPER,Return,exec,${pkgs.kitty}/bin/kitty
    bind=SUPER,Escape,exit,
    bind=SUPER,Q,killactive,
    bind=SUPER,L,exec,${pkgs.swaylock}/bin/swaylock
    bind=SUPER,E,exec,${pkgs.pcmanfm}/bin/pcmanfm
    bind=SUPER,H,togglefloating,
    bind=SUPER,Space,exec,${pkgs.wofi}/bin/wofi --show drun
    bind=SUPER,F,fullscreen,
    bind=SUPER,R,togglesplit,
    bind=SUPERSHIFT,F,forcerendererreload,
    bind=SUPERSHIFT,R,exec,${pkgs.hyprland}/bin/hyprctl reload
  '';

  windowRules = ''
    windowrule=float,title:^(Volume Control)$
    windowrule=float,title:^(Picture-in-Picture)$
    windowrule=pin,title:^(Picture-in-Picture)$
    windowrule=move 75% 75% ,title:^(Picture-in-Picture)$
    windowrule=size 24% 24% ,title:^(Picture-in-Picture)$
    windowrule=float,title:^(Media viewer)$
    windowrulev2=float,class:^(code)$,title:^(Open File)$
  '';

  hyprlandConf = ''
    general {
      border_size=1
      gaps_in=4
      gaps_out=8
      layout=dwindle
    }

    decoration {
      multisample_edges = false
      fullscreen_opacity = 1
      inactive_opacity = 0.9
      active_opacity = 1
      drop_shadow = false
      blur = true
      rounding = 0
    }

    animations {
      enabled = true
    }

    input {
      kb_layout = us
      kb_options = octopus:octopus
      follow_mouse = 2
      repeat_delay = 250
      numlock_by_default = 1
      accel_profile = flat
      sensitivity = 0
    }

    dwindle {
      pseudotile = false
      preserve_split = true
      force_split = 2
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
