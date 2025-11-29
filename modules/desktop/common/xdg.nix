{
  flake.modules.nixos.desktop = {pkgs, ...}: {
    xdg.portal = {
      enable = true;
      config.common.default = [
        "gtk"
        "gnome"
      ];

      # Sets environment variable NIXOS_XDG_OPEN_USE_PORTAL to 1
      # This will make xdg-open use the portal to open programs,
      # which resolves bugs involving programs opening inside FHS envs or with unexpected env vars set from wrappers.
      # xdg-open is used by almost all programs to open a unknown file/uri
      # alacritty as an example, it use xdg-open as default, but you can also custom this behavior
      # and vscode has open like `External Uri Openers`
      xdgOpenUsePortal = true;

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
      kvantummanager = {
        name = "kvantum";
        noDisplay = true;
      };
    };
  };
}
