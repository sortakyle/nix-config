{
  hosts.nixos.caprica = {
    compositor = "hyprland";
    environment = "dms";
    wallpaper-directory = "%h/Pictures/Wallpapers/";

    monitors = [
      {
        name = "DP-2";
        width = 3840;
        height = 2160;
        refreshRate = 240;
        primary = true;
        x = 0;
        y = 0;
      }
      {
        name = "DP-3";
        width = 3840;
        height = 2160;
        refreshRate = 240;
        x = 3840;
        y = 0;
      }
      {
        name = "DP-4";
        width = 3840;
        height = 2160;
        refreshRate = 240;
        x = -3840;
        y = 0;
      }
      {
        # I have no idea what this is
        name = "DP-1";
        width = 1024;
        height = 768;
        enabled = false;
      }
    ];
  };
}
