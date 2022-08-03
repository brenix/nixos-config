{ inputs, lib, config, pkgs, hostname, ... }: {
  imports = [
    ../common
    ../common/wayland-wm
    inputs.hyprland.homeManagerModules.default
  ];

  wayland.windowManager.hyprland =
    let
      inherit (config.colorscheme) colors;
      mako = "${pkgs.mako}/bin/mako";
      swaybg = "${pkgs.swaybg}/bin/swaybg";
    in
    {
      enable = true;
      package = pkgs.hyprland;
      extraConfig =
        (lib.optionalString (hostname == "neo") ''
          monitor=DP-1,2560x1440@165,0x0,1
          workspace=DP-1,1
          workspace=DP-1,2
          monitor=HDMI-A-1,2560x1440@144,2560x0,1
          workspace=HDMI-A-1,3
          workspace=HDMI-A-1,4
        '') +
        ''
          general {
            main_mod=SUPER
            gaps_in=15
            gaps_out=15
            border_size=2
            col.active_border=0xff${colors.base0C}
            col.inactive_border=0xff${colors.base02}
            cursor_inactive_timeout=4
          }

          decoration {
            active_opacity=1.0
            inactive_opacity=1.0
            fullscreen_opacity=1.0
            rounding=3
            blur=false
            blur_size=2
            blur_passes=5
            drop_shadow=true
            shadow_range=12
            shadow_offset=3 3
            col.shadow=0x44000000
            col.shadow_inactive=0x66000000
          }

          animations {
            enabled=true
            animation=windows,1,4,default,slide
            animation=border,1,5,default
            animation=fade,1,7,default
            animation=workspaces,1,2,default
          }

          dwindle {
            force_split=2
            preserve_split=true
            col.group_border_active=0xff${colors.base0B}
            col.group_border=0xff${colors.base04}
          }

          input {
            kb_layout=us
            kb_options=caps:escape
            repeat_rate=50
            repeat_delay=195
            force_no_accel=1
          }

          # Startup
          exec-once=waybar
          exec=${swaybg} -i ${config.wallpaper} --mode fill
          exec-once=${mako}

          # Program bindings
          bind=SUPER,Return,exec,foot
          bind=SUPERSHIFT,Return,exec,foot -a foot:floating
          bind=SUPER,Space,exec,wofi
          bind=SUPER,d,exec,firefox
          bind=SUPER,s,exec,spotify
          bind=SUPERSHIFT,s,exec,slack
          bind=SUPER,v,exec,pavucontrol
          bind=SUPERCONTROL,s,exec,spotify
          bind=SUPERSHIFT,d,exec,discocss
          bind=,Print,exec,flameshot

          # Audio
          bind=,XF86AudioNext,exec,playerctl next
          bind=,XF86AudioPrev,exec,playerctl previous
          bind=,XF86AudioPlay,exec,playerctl play-pause
          bind=,XF86AudioStop,exec,playerctl stop
          bind=,XF86AudioRaiseVolume,exec,pamixer -i 5
          bind=,XF86AudioLowerVolume,exec,pamixer -d 5
          bind=,XF86AudioMute,exec,pamixer -t

          # Window manager controls
          bind=SUPER,w,killactive
          bind=SUPERSHIFT,q,exit
          bind=SUPERSHIFT,r,exec,hyprctl reload

          bind=SUPER,r,togglesplit
          bind=SUPER,f,togglefloating
          bind=SUPERSHIFT,f,fullscreen,0

          bind=SUPER,minus,splitratio,-0.25
          bind=SUPERSHIFT,underscore,splitratio,-0.3333333

          bind=SUPER,equal,splitratio,0.25
          bind=SUPERSHIFT,plus,splitratio,0.3333333

          bind=SUPER,g,togglegroup
          bind=SUPER,apostrophe,changegroupactive,f
          bind=SUPERSHIFT,quotedbl,changegroupactive,b

          bind=SUPER,left,movefocus,l
          bind=SUPER,right,movefocus,r
          bind=SUPER,up,movefocus,u
          bind=SUPER,down,movefocus,d
          bind=SUPER,h,movefocus,l
          bind=SUPER,l,movefocus,r
          bind=SUPER,k,movefocus,u
          bind=SUPER,j,movefocus,d

          bind=SUPERSHIFT,left,movewindow,l
          bind=SUPERSHIFT,right,movewindow,r
          bind=SUPERSHIFT,up,movewindow,u
          bind=SUPERSHIFT,down,movewindow,d
          bind=SUPERSHIFT,h,movewindow,l
          bind=SUPERSHIFT,l,movewindow,r
          bind=SUPERSHIFT,k,movewindow,u
          bind=SUPERSHIFT,j,movewindow,d

          bind=SUPERCONTROL,left,focusmonitor,l
          bind=SUPERCONTROL,right,focusmonitor,r
          bind=SUPERCONTROL,up,focusmonitor,u
          bind=SUPERCONTROL,down,focusmonitor,d
          bind=SUPERCONTROL,h,focusmonitor,l
          bind=SUPERCONTROL,l,focusmonitor,r
          bind=SUPERCONTROL,k,focusmonitor,u
          bind=SUPERCONTROL,j,focusmonitor,d

          bind=SUPERCONTROL,1,focusmonitor,DP-1
          bind=SUPERCONTROL,2,focusmonitor,HDMI-A-1

          bind=SUPERCONTROLSHIFT,left,movewindow,mon:l
          bind=SUPERCONTROLSHIFT,right,movewindow,mon:r
          bind=SUPERCONTROLSHIFT,up,movewindow,mon:u
          bind=SUPERCONTROLSHIFT,down,movewindow,mon:d
          bind=SUPERCONTROLSHIFT,h,movewindow,mon:l
          bind=SUPERCONTROLSHIFT,l,movewindow,mon:r
          bind=SUPERCONTROLSHIFT,k,movewindow,mon:u
          bind=SUPERCONTROLSHIFT,j,movewindow,mon:d

          bind=SUPERCONTROLSHIFT,1,movewindow,mon:DP-1
          bind=SUPERCONTROLSHIFT,2,movewindow,mon:HDMI-A-1

          bind=SUPERALT,left,movecurrentworkspacetomonitor,l
          bind=SUPERALT,right,movecurrentworkspacetomonitor,r
          bind=SUPERALT,up,movecurrentworkspacetomonitor,u
          bind=SUPERALT,down,movecurrentworkspacetomonitor,d
          bind=SUPERALT,h,movecurrentworkspacetomonitor,l
          bind=SUPERALT,l,movecurrentworkspacetomonitor,r
          bind=SUPERALT,k,movecurrentworkspacetomonitor,u
          bind=SUPERALT,j,movecurrentworkspacetomonitor,d

          bind=SUPER,u,togglespecialworkspace
          bind=SUPERSHIFT,u,movetoworkspace,special

          bind=SUPER,1,workspace,1
          bind=SUPER,2,workspace,2
          bind=SUPER,3,workspace,3
          bind=SUPER,4,workspace,4
          bind=SUPER,5,workspace,5
          bind=SUPER,6,workspace,6
          bind=SUPER,7,workspace,7
          bind=SUPER,8,workspace,8
          bind=SUPER,9,workspace,9
          bind=SUPER,0,workspace,10

          bind=SUPERSHIFT,exclam,movetoworkspacesilent,1
          bind=SUPERSHIFT,at,movetoworkspacesilent,2
          bind=SUPERSHIFT,numbersign,movetoworkspacesilent,3
          bind=SUPERSHIFT,dollar,movetoworkspacesilent,4
          bind=SUPERSHIFT,percent,movetoworkspacesilent,5
          bind=SUPERSHIFT,asciicircum,movetoworkspacesilent,6
          bind=SUPERSHIFT,ampersand,movetoworkspacesilent,7
          bind=SUPERSHIFT,asterisk,movetoworkspacesilent,8
          bind=SUPERSHIFT,parenleft,movetoworkspacesilent,9
          bind=SUPERSHIFT,parenright,movetoworkspacesilent,10

          blurls=waybar
        '';
    };
}
