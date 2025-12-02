{
  flake.modules.homeManager.desktop-dms = {
    pkgs,
    host,
    ...
  }: let
    swww-random-wallpaper = pkgs.writeShellScript "swww-random-wallpaper" ''
      #!/usr/bin/env bash

      INTERVAL=300

      while true; do
        find "$1" -type f \
          | while read -r img; do
            echo "$((RANDOM % 1000)):$img"
          done \
          | sort -n | cut -d':' -f2- \
          | while read -r img; do
            swww img "$img" --transition-fps 60 --transition-type any
            sleep $INTERVAL
          done
      done
    '';
  in {
    services.swww = {
      enable = true;
    };

    systemd.user.services.swww-random-wallpaper = {
      Unit = {
        Description = "swww daemon to select a random wallpaper";
        PartOf = ["swww.service"];
        After = ["swww.service"];
      };

      Service = {
        ExecStart = "${swww-random-wallpaper} ${host.wallpaper-directory}";
        Restart = "on-failure";
      };

      Install.WantedBy = ["swww.service"];
    };
  };
}
