{
  flake.modules.homeManager.desktop-hyprland = {
    lib,
    pkgs,
    ...
  }: {
    wayland.windowManager.hyprland.settings = {
      permission = [
        # screencopy asks for permission to capture the screen by default, allow expected programs
        "${lib.getExe pkgs.grim}, screencopy, allow"
        "${lib.getExe pkgs.hyprlock}, screencopy, allow"
        "${lib.getExe pkgs.hyprpicker}, screencopy, allow"
        "${pkgs.xdg-desktop-portal-hyprland}/libexec/.xdg-desktop-portal-hyprland-wrapped, screencopy, allow"
      ];
    };
  };
}
