{
  flake.modules.homeManager.desktop-hyprland = {pkgs, ...}: let
    brightnessctl = "${pkgs.brightnessctl}/bin/brightnessctl";
    playerctl = "${pkgs.playerctl}/bin/playerctl";
    wpctl = "${pkgs.wireplumber}/bin/wpctl";
  in {
    wayland.windowManager.hyprland.settings = {
      "$MOD" = "SUPER";

      input = {
        # numlock_by_deafult = true;

        # Must click a window to change focus, including floating windows
        follow_mouse = 2;
        float_switch_override_focus = 0;

        # Mouse & Trackpad Sensitivity
        accel_profile = "flat";
        sensitivity = 0.0;
        touchpad = {
          natural_scroll = true;
          clickfinger_behavior = true;
          disable_while_typing = true;
          tap-to-click = false;
          tap-and-drag = false;
        };
      };

      # Mouse bindings to drag windows
      bindm = [
        "$MOD, mouse:272, movewindow"
        "$MOD, mouse:273, resizewindow"
      ];

      bind = [
        # Core Bindings
        "$MOD, Q, killactive"
        "$MOD, F, fullscreen"
        "$MOD, Space, togglefloating"
        "$MOD, X, togglesplit,"
        "$MOD, P, pseudo,"
        "$MOD, G, togglegroup"

        # Scroll switch between workspaces on a monitor
        "$MOD, mouse_down, workspace, e+1"
        "$MOD, mouse_up, workspace, e-1"

        # Swap to next/prev position
        "$MOD, TAB, cyclenext"
        "$MOD, TAB, bringactivetotop"
        "$MOD, TAB, changegroupactive"

        # Move Window or Group (arrow keys & hjkl)
        "$MOD SHIFT, LEFT,   movewindoworgroup, l"
        "$MOD SHIFT, RIGHT,  movewindoworgroup, r"
        "$MOD SHIFT, UP,     movewindoworgroup, u"
        "$MOD SHIFT, DOWN,   movewindoworgroup, d"
        "$MOD SHIFT, H,      movewindoworgroup, l"
        "$MOD SHIFT, J,      movewindoworgroup, d"
        "$MOD SHIFT, K,      movewindoworgroup, u"
        "$MOD SHIFT, L,      movewindoworgroup, r"

        # Focus Window (arrow keys & hjkl)
        "$MOD, LEFT,   movefocus, l"
        "$MOD, RIGHT,  movefocus, r"
        "$MOD, UP,     movefocus, u"
        "$MOD, DOWN,   movefocus, d"
        "$MOD, K,      movefocus, u"
        "$MOD, J,      movefocus, d"
        "$MOD, L,      movefocus, r"
        "$MOD, H,      movefocus, l"
      ];

      binde = [
        # Resize Window (arrow keys & hjkl)
        "$MOD CTRL, LEFT,   resizeactive, -20 0"
        "$MOD CTRL, RIGHT,  resizeactive, 20 0"
        "$MOD CTRL, UP,     resizeactive, 0 -20"
        "$MOD CTRL, DOWN,   resizeactive, 0 20"
        "$MOD CTRL, K,      resizeactive, 0 -20"
        "$MOD CTRL, J,      resizeactive, 0 20"
        "$MOD CTRL, L,      resizeactive, 20 0"
        "$MOD CTRL, H,      resizeactive, -20 0"
      ];

      bindl = [
        # Hardware controls
        ",XF86AudioMute, exec, ${wpctl} set-mute @DEFAULT_SINK@ toggle"
        ",XF86AudioMicMute, exec, ${wpctl} set-mute @DEFAULT_SOURCE@ toggle"
        ",XF86AudioNext, exec, ${playerctl} next"
        ",XF86AudioPlay, exec, ${playerctl} play-pause"
        ",XF86AudioPrev, exec, ${playerctl} previous"
      ];

      bindle = [
        # Hardware controls (repeatable)
        ",XF86MonBrightnessUp, exec, ${brightnessctl} set 5%+"
        ",XF86MonBrightnessDown, exec, ${brightnessctl} set 5%-"
        ",XF86AudioRaiseVolume, exec, ${wpctl} set-volume @DEFAULT_SINK@ 5%+"
        ",XF86AudioLowerVolume, exec, ${wpctl} set-volume @DEFAULT_SINK@ 5%-"
      ];
    };
  };
}
