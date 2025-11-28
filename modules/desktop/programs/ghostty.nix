{
  flake.modules.homeManager.desktop = {
    programs.ghostty = {
      enable = true;
      settings = {
        "scrollback-limit" = 4294967295;
        "window-decoration" = false;
        "window-padding-x" = 20;
        "window-padding-y" = 20;
      };
    };

    stylix.targets.ghostty.enable = true;

    xdg.mimeApps = {
      associations.added = {
        "x-scheme-handler/terminal" = "com.mitchellh.ghostty.desktop";
      };
      defaultApplications = {
        "x-scheme-handler/terminal" = "com.mitchellh.ghostty.desktop";
      };
    };

    # Bindings for Hyprland compositor
    wayland.windowManager.hyprland.settings = {
      bind = [
        "$MOD, Return, exec, app2unit -- ghostty"
        "ALT, Return, exec, app2unit -- ghostty --class=floating.ghostty"
      ];

      windowrulev2 = [
        "float, class:floating.ghostty"
        "size 1200 700, class:floating.ghostty"
      ];
    };
  };
}
