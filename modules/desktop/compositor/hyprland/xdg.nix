{
  flake.modules.nixos.desktop-hyprland = {pkgs, ...}: {
    xdg.portal = {
      enable = true;
      extraPortals = with pkgs; [
        xdg-desktop-portal-hyprland
        xdg-desktop-portal-gtk
      ];
      configPackages = [pkgs.hyprland];
      config.hyprland = {
        "org.freedesktop.impl.portal.ScreenCast" = "hyprland";
      };
    };
  };
}
