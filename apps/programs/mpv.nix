{
  flake.modules.homeManager.programs = {pkgs, ...}: {
    programs.mpv = {
      enable = true;
      defaultProfiles = ["gpu-hq"];
      scripts = with pkgs.mpvScripts; [
        mpris
        mpv-cheatsheet
      ];
    };

    xdg.mimeApps.defaultApplications = {
      "audio/*" = ["mpv.desktop"];
      "video/*" = ["mpv.desktop"];
    };
  };
}
