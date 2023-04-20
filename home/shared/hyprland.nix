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

    bind=ALT,left,workspace,-1
    bind=ALT,right,workspace,+1

    bind=ALTSHIFT,left,movetoworkspace,-1
    bind=ALTSHIFT,right,movetoworkspace,+1

    bind=SUPER,Return,exec,${pkgs.kitty}/bin/kitty
    bind=SUPER,Escape,exit,
    bind=SUPER,Q,killactive,
    bind=SUPER,L,exec,${pkgs.swaylock}/bin/swaylock
    bind=SUPER,E,exec,${pkgs.pcmanfm}/bin/pcmanfm
    bind=SUPER,H,togglefloating,
    bind=SUPER,Space,exec,${pkgs.wofi}/bin/wofi --show drun
    bind=SUPER,F,fullscreen,
    bind=SUPER,R,forcerendererreload,
    bind=SUPERSHIFT,R,exec,${pkgs.hyprland}/bin/hyprctl reload
  '';

  windowRules = ''
    windowrule=float,title:^(Volume Control)$
    windowrule=float,title:^(Picture-in-Picture)$
    windowrule=pin,title:^(Picture-in-Picture)$
    windowrule=move 75% 75% ,title:^(Picture-in-Picture)$
    windowrule=size 24% 24% ,title:^(Picture-in-Picture)$
  '';

  hyprlandConf = ''
    general {
      border_size=3
      gaps_in=5
      gaps_out=7
      layout=dwindle
    }

    decoration {
      multisample_edges = true
      fullscreen_opacity = 1
      inactive_opacity = 0.8
      active_opacity = 0.93
      drop_shadow = false
      blur = true
      rounding = 5
    }

    animations {
      enabled = true
    }

    input {
      kb_layout = us
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
}
