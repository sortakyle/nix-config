{
  flake.modules.homeManager.desktop = {config, ...}: {
    # Manages file associations with default programs
    xdg.mimeApps.enable = true;

    # Enable the default user directories within home
    # Music, Videos, Desktop, Public, Pictures, Downloads, Documents, Templates
    xdg.userDirs.enable = true;

    # Hiding the Desktop directory since I prefer to not use it
    # alternatively can set it to NULL so XDG_DESKTOP_DIR is unset
    xdg.userDirs.desktop = "${config.home.homeDirectory}/.desktop";

    home.sessionVariables = {
      XDG_SCREENSHOTS_DIR = "${config.xdg.userDirs.pictures}/Screenshots";
    };

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
      kvantummanager = {
        name = "kvantum";
        noDisplay = true;
      };
    };

    # User directories to preserve. Trying to keep a minimal set
    home.preserve.directories = [
      "Documents"
      "Pictures"
      "Music"
      "Videos"
    ];
  };
}
