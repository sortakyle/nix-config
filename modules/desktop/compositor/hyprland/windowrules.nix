{
  flake.modules.homeManager.desktop-hyprland = {
    wayland.windowManager.hyprland.settings = {
      # Generic window rules that should be mostly app agnostic
      windowrule = [
        "float on, size (monitor_w*0.5) (monitor_h*0.5), match:class floating.terminal"
      ];
    };
  };
}
