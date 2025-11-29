{
  flake.modules.nixos.desktop = {pkgs, ...}: {
    environment.systemPackages = with pkgs; [
      nemo-with-extensions
    ];
  };

  flake.modules.homeManager.desktop = {pkgs, ...}: {
    xdg.desktopEntries.nemo = {
      name = "Nemo";
      exec = "${pkgs.nemo-with-extensions}/bin/nemo";
      icon = "nemo";
      genericName = "File Manager";
    };

    xdg.mimeApps.defaultApplications = {
      "inode/directory" = ["nemo.desktop"];
      "application/x-gnome-saved-search" = ["nemo.desktop"];
    };

    # use dconf2nix to extract configured preferences
    dconf.settings = {
      "org/cinnamon/desktop/applications/terminal" = {
        exec = "ghostty";
      };

      "org/nemo/plugins" = {
        disabled-actions = [
          "set-as-background.nemo_action"
          "set-resolution.nemo_action"
          "change-background.nemo_action"
          "add-desklets.nemo_action"
          "90_new-launcher.nemo_action"
        ];
      };

      "org/nemo/preferences" = {
        default-folder-viewer = "icon-view";
        "inherit-folder-viewer" = true;
        show-compact-view-icon-toolbar = false;
        show-computer-icon-toolbar = false;
        show-edit-icon-toolbar = true;
        show-home-icon-toolbar = false;
        show-open-in-terminal-toolbar = false;
        show-reload-icon-toolbar = true;
        show-show-thumbnails-toolbar = false;
      };

      "org/nemo/preferences/menu-config" = {
        background-menu-open-as-root = false;
      };
    };
  };
}
