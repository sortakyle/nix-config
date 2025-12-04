{
  flake.modules.homeManager.desktop-hyprland = {
    wayland.windowManager.hyprland.settings = {
      general = {
        layout = "dwindle";

        # Cursor
        no_focus_fallback = true;

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

      # Enables the color management protocol for supporting HDR
      experimental = {
        xx_color_management_v4 = true;
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
        middle_click_paste = false;

        # variable refresh rate
        vfr = true;
        vrr = 1;
      };

      dwindle = {
        pseudotile = true;
        preserve_split = true;
      };

      xwayland.force_zero_scaling = true;
    };
  };
}
