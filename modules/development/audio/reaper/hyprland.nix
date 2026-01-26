{
  flake.modules.homeManager.development = {
    wayland.windowManager.hyprland.settings = {
      windowrule = [
        # REAPER tooltip fix
        # https://github.com/hyprwm/Hyprland/issues/2278
        "no_focus on, match:class REAPER, match:title ^$"
      ];
    };
  };
}
