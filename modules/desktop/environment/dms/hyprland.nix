{
  flake.modules.homeManager.desktop-dms = {
    wayland.windowManager.hyprland.settings = {
      general = {
        gaps_in = 4;
        gaps_out = 4;
        border_size = 0;
      };

      decoration = {
        rounding = 10;
        dim_special = 0.3;

        # Default opacity settings for this DE
        # Setting to 1.0 to instead use window rules to configure opacity
        active_opacity = 1.0;
        inactive_opacity = 1.0;
        fullscreen_opacity = 1.0;

        # Blur behind transparency
        blur = {
          enabled = true;
          new_optimizations = true;
          ignore_opacity = true;
          special = true;
          xray = false;
          size = 6;
          passes = 2;
          # noise = 0.02;
          contrast = 1.1;
          vibrancy = 0.2;
          vibrancy_darkness = 0.3;
        };

        # Shadow
        shadow = {
          enabled = true;
          range = 40;
          render_power = 5;
          offset = "0 5";
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

      bind = [
        "$MOD, R, exec, dms ipc call spotlight toggle"
      ];

      layerrule = [
        "animation popin, dms:osd"
        "abovelock, dms:osd"

        "dimaround, dms:(color-picker|clipboard|spotlight|settings)"
        "animation popin, dms:(color-picker|clipboard|spotlight|settings)"
      ];

      windowrulev2 = [
        # Opacity Rules
        "opacity 1.00 0.8, floating:0" # reduce opacity of inactive non-floating windows
        "opacity 0.95 0.8, floating:1" # floating windows have less opacity when active

        # Application opacity ruiles

        "idleinhibit fullscreen, class:^(firefox)$"
        "float, class:^(org.quickshell)$"
      ];
    };
  };
}
