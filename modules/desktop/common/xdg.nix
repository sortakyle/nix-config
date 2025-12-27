{
  flake.modules.nixos.desktop = {
    # User directories to preserve. Trying to keep a minimal set
    preserve.users.directories = [
      "Documents"
      "Pictures"
      "Videos"
    ];
  };

  flake.modules.homeManager.desktop = {config, ...}: {
    # Manages file associations with default programs
    xdg.mimeApps.enable = true;

    # Enable the default user directories within home
    # Music, Videos, Desktop, Public, Pictures, Downloads, Documents, Templates
    xdg.userDirs.enable = true;

    # Hiding the Desktop directory since I prefer to not use it
    # alternatively can set it to NULL so XDG_DESKTOP_DIR is unset
    xdg.userDirs.desktop = "${config.home.homeDirectory}/.desktop";

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
  };
}
