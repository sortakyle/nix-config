{
  flake.modules.homeManager.desktop-hyprland = {host, ...}: {
    wayland.windowManager.hyprland.settings = {
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
    };
  };
}
