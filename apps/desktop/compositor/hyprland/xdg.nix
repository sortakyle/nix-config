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
        default = [
          "hyprland"
          "gtk"
        ];
        "org.freedesktop.impl.portal.OpenURI" = "gtk";
        "org.freedesktop.impl.portal.FileChooser" = "gtk";
        "org.freedesktop.impl.portal.Print" = "gtk";
        "org.freedesktop.impl.portal.ScreenCast" = "hyprland";
      };
    };
  };
}
