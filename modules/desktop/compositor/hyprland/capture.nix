{
  flake.modules.homeManager.desktop-hyprland = {pkgs, ...}: {
    home.packages = with pkgs; [
      grim
      grimblast
      slurp
      hyprpicker
      stable.wl-screenrec
      cliphist
      wl-clipboard
    ];
  };
}
