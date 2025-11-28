{
  flake.modules.homeManager.desktop-hyprland = {
    wayland.windowManager.hyprland.settings = {
      general = {
        layout = "dwindle";

        # Cursor
        no_focus_fallback = true;

        # Gaps
        gaps_in = 5;
        gaps_out = 5;

        # Borders
        border_size = 0;

        # Resize
        resize_on_border = false;
        hover_icon_on_border = false;

        # Allow tearing (you must add a window rule to the window to allow tearing)
        allow_tearing = false;
      };

      cursor = {
        inactive_timeout = 900; # Hide the cursor after n ms
        no_warps = true; # Never move the cursor automatically
      };

      ecosystem = {
        enforce_permissions = true;
        no_donation_nag = true;
        no_update_news = true;
      };

      misc = {
        # Allow windows to steal focus
        focus_on_activate = false;

        # Doing my own wallpaper + themeing
        disable_hyprland_logo = true;
        disable_splash_rendering = true;

        # nice settings
        animate_mouse_windowdragging = false;
        key_press_enables_dpms = true;

        # variable refresh rate
        vfr = true;
        vrr = 1;
      };

      decoration = {
        # Round borders
        rounding = 8;

        # Shadow
        shadow = {
          enabled = true;
          range = 40;
          render_power = 5;
          offset = "0 5";
        };

        active_opacity = 1.0;
        inactive_opacity = 0.9;
        fullscreen_opacity = 1.0;

        blur = {
          enabled = true;
          new_optimizations = true;
          ignore_opacity = true;
          xray = false;
          size = 6;
          passes = 2;
        };
      };

      animations = {
        enabled = true;

        bezier = [
          "customBezier, 0.05, 0.9, 0.1, 1.05"
          "easeoutquad, 0.25, 0.46, 0.45, 0.94"
          "easeinoutcirc, 0.785, 0.135, 0.15, 0.86"
        ];

        animation = [
          "border, 1, 5, easeoutquad"

          "fadeIn, 1, 3, easeoutquad"
          "fadeOut, 1, 3, easeoutquad"
          "fadeLayers, 1, 3, easeoutquad"
          "fadeSwitch, 1, 5, easeoutquad"

          "layers, 1, 3, easeinoutcirc, slide"

          "windowsIn, 1, 5, easeoutquad, slide"
          "windowsOut, 1, 5, easeoutquad, slide"
          "windowsMove, 1, 5, easeinoutcirc, slide"

          "workspaces, 1, 3, easeinoutcirc, slideFade"
          "specialWorkspace, 1, 3, easeinoutcirc, slideFade"
        ];
      };

      dwindle = {
        pseudotile = true;
        preserve_split = true;
      };

      xwayland.force_zero_scaling = true;
    };
  };
}
