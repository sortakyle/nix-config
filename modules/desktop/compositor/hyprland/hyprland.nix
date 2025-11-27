{
  flake.modules.nixos.desktop-hyprland = {
    programs.hyprland = {
      enable = true;
      withUWSM = true;
      xwayland.enable = true;
    };
  };

  flake.modules.homeManager.desktop-hyprland = {host, ...}: {
    home.sessionVariables = {
      MOZ_ENABLE_WAYLAND = 1;
      QT_QPA_PLATFORM = "wayland";
      SDL_VIDEODRIVER = "wayland";
      XDG_SESSION_TYPE = "wayland";
      ELECTRON_OZONE_PLATFORM_HINT = "auto";
      QT_QPA_PLATFORMTHEME = "gtk3";
      QT_QPA_PLATFORMTHEME_QT6 = "gtk3";
    };

    stylix.targets = {
      gtk.enable = true;
      hyprland.enable = true;
      hyprland.hyprpaper.enable = true;
      nixos-icons.enable = true;
      qt.enable = true;
    };

    wayland.windowManager.hyprland = {
      enable = true;
      # package = null;
      # portalPackage = null;

      # utilizing uwsm for systemd units
      systemd.enable = false;

      settings = {
        "$MOD" = "SUPER";

        # startup programs
        exec-once = [
          "uwsm app -s s -- wl-paste --type text --watch cliphist store"
          "uwsm app -s s -- wl-paste --type image --watch cliphist store"
        ];

        ecosystem = {
          enforce_permissions = true;
          no_donation_nag = true;
          no_update_news = true;
        };

        permission = [];

        general = {
          border_size = 2;
          gaps_in = 19;
          gaps_out = 15;
          layout = "dwindle";
        };

        cursor = {
          no_warps = true;
        };

        monitor =
          if builtins.length host.monitors > 0
          then
            map (
              m: let
                resolution = "${toString m.width}x${toString m.height}@${toString m.refreshRate}";
                position = "${toString m.x}x${toString m.y}";
                transform = "transform,${toString m.transform}";
              in "${m.name},${
                if m.enabled
                then "${resolution},${position},1"
                else "disable"
              },${
                if m.enabled
                then "${transform}"
                else ""
              }"
            )
            host.monitors
          else [",highres,auto,1"];

        decoration = {
          active_opacity = 1.0;
          inactive_opacity = 0.95;
          fullscreen_opacity = 1.0;
          rounding = 10;
        };

        animations = {
          enabled = true;
          bezier = [
            "easeoutquad, 0.25, 0.46, 0.45, 0.94"
            "easeinoutcirc, 0.785, 0.135, 0.15, 0.86"
          ];
        };

        input = {
          kb_options = "caps:super";
          # mouse settings
          accel_profile = "flat";
          sensitivity = 0.0;
          follow_mouse = 2;
          touchpad = {
            natural_scroll = true;
          };
        };

        misc = {
          animate_mouse_windowdragging = true;
          disable_hyprland_logo = true;
          disable_splash_rendering = true;
          # `hyprctl reload` to reload
          disable_autoreload = true;
          key_press_enables_dpms = true;
          vrr = 1;
        };

        bind = [
          "$MOD, T, exec, uwsm app -- kitty"

          "$MOD, R, exec, walker"
          "$MOD, C, exec, walker -m clipboard"

          "$MOD, Q, killactive"
          "$MODSHIFT, Q, exit"
          "$MOD, F, fullscreen"
          "$MOD, Space, togglefloating"
          "$MODSHIFT, Space, workspaceopt, allfloat"

          "$MOD, Tab, swapnext"
          "$MODSHIFT, Tab, swapnext, prev"

          "$MOD, K, movefocus, u"
          "$MOD, J, movefocus, d"
          "$MOD, L, movefocus, r"
          "$MOD, H, movefocus, l"

          "$MODCTRL, K, swapwindow, u"
          "$MODCTRL, J, swapwindow, d"
          "$MODCTRL, L, swapwindow, r"
          "$MODCTRL, H, swapwindow, l"

          "$MODSHIFT, K, movewindoworgroup, u"
          "$MODSHIFT, J, movewindoworgroup, d"
          "$MODSHIFT, L, movewindoworgroup, r"
          "$MODSHIFT, H, movewindoworgroup, l"

          "$MOD, mouse_down, workspace, m-1"
          "$MOD, mouse_up, workspace, m+1"
        ];

        bindm = [
          "$MOD, mouse:272, movewindow"
          "$MOD, mouse:273, resizewindow"
        ];

        layerrule = [
          "animation popin, (osd-.*)"
          "abovelock, (osd-.*)"
        ];

        windowrulev2 = [
          "idleinhibit fullscreen, class:^(firefox)$"
          "float, class:^(org.quickshell)$"
        ];

        xwayland.force_zero_scaling = true;
      };
      # order matters
      extraConfig = ''
        # group "tabbed" management
        bind = $MOD, G, submap, group

        submap = group
        bind = $MOD, G, togglegroup
        bind = $MOD, G, submap, reset
        bind = $MOD, Tab, changegroupactive, f
        bind = $MODSHIFT, Tab, changegroupactive, b
        bind = $MOD, 1, changegroupactive, 1
        bind = $MOD, 2, changegroupactive, 2
        bind = $MOD, 3, changegroupactive, 3
        bind = $MOD, 4, changegroupactive, 4
        bind = $MOD, 5, changegroupactive, 5
        bind = $MOD, 6, changegroupactive, 6
        bind = $MOD, l, lockgroups, toggle
        bind = , catchall, submap, reset
        submap = reset
      '';
    };

    # TODO: temporary
    programs.kitty.enable = true;
  };
}
