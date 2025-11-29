{
  flake.modules.homeManager.desktop-dms = {
    pkgs,
    host,
    ...
  }: {
    services.swww = {
      enable = true;
    };

    home.packages = [
      # Takes in a directory for wallpapers and will change wallpapers every INTERVAL
      (pkgs.writeShellScriptBin "swww-random-wallpaper" ''
        #!/usr/bin/env bash

        INTERVAL=300

        while true; do
          find "$1" -type f \
            | while read -r img; do
              echo "$((RANDOM % 1000)):$img"
            done \
            | sort -n | cut -d':' -f2- \
            | while read -r img; do
              swww img "$img"
              sleep $INTERVAL
            done
        done
      '')
    ];

    wayland.windowManager.hyprland.settings = {
      exec-once = [
        "swww-random-wallpaper ${host.wallpaper-directory}"
      ];
    };
  };
}
