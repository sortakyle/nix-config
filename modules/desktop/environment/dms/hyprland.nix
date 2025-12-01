{
  flake.modules.homeManager.desktop-hyprland = {
    flake.modules.homeManager.desktop-hyprland = {
      settings = {
        bind = [
          "$MOD, R, exec, dms ipc call spotlight toggle"
        ];

        layerrule = [
          "animation popin, (osd-.*)"
          "abovelock, (osd-.*)"
          "noanim, ^(dms)$"
        ];

        windowrulev2 = [
          # "opacity 0.9 0.9, floating:0, focus:0"
          "idleinhibit fullscreen, class:^(firefox)$"
          "float, class:^(org.quickshell)$"
        ];
      };
    };
  };
}
