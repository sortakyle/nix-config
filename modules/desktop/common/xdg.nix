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
  };
}
