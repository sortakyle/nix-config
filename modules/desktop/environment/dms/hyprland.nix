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
      };

      bind = [
        "$MOD, R, exec, dms ipc call spotlight toggle"
      ];

      layerrule = [
        "animation popin, (osd-.*)"
        "abovelock, (osd-.*)"
        "noanim, ^(dms)$"
      ];

      windowrulev2 = [
        # Opacity Rules
        "opacity 1.00 0.8, floating:0" # reduce opacity of inactive non-floating windows
        "opacity 0.95 0.8, floating:1" # floating windows have less opacity when active

        "opacity 0.95, class:vesktop"
        # "opacity 0.8 0.7, class:^(VSCodium|codium-url-handler|code|code-url-handler)$"

        "idleinhibit fullscreen, class:^(firefox)$"
        "float, class:^(org.quickshell)$"
      ];
    };
  };
}
