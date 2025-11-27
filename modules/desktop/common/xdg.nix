{
  flake.modules.nixos.desktop = {pkgs, ...}: {
    xdg.portal = {
      enable = true;
      config.common.default = [
        "gtk"
        "gnome"
      ];
      extraPortals = with pkgs; [
        xdg-desktop-portal-gtk # for file picker / OpenURI
        xdg-desktop-portal-gnome # for screensharing
      ];
    };

    # User directories to preserve. Trying to keep a minimal set
    preserve.users.directories = [
      "Documents"
      "Pictures"
      "Videos"
    ];
  };

  flake.modules.homeManager.desktop = {
    # Manages file associations with default programs
    xdg.mimeApps.enable = true;

    # Enable the default user directories within home
    # Music, Videos, Desktop, Public, Pictures, Downloads, Documents, Templates
    xdg.userDirs.enable = true;

    # Hide the following desktop entries. Never want to launch these from a launcher
    xdg.desktopEntries = {
      uuctl = {
        name = "uuctl";
        noDisplay = true;
      };
      micro = {
        name = "micro";
        noDisplay = true;
      };
      qt5ct = {
        name = "qt6ct";
        noDisplay = true;
      };
      qt6ct = {
        name = "qt6ct";
        noDisplay = true;
      };
    };
  };
}
