{
  flake.modules.homeManager.desktop-hyprland = {
    stylix.targets = {
      gtk.enable = true;
      hyprland.enable = true;
      hyprland.hyprpaper.enable = true;
      nixos-icons.enable = true;
      qt.enable = true;
    };
  };
}
