{
  flake.modules.nixos.programs = {pkgs, ...}: {
    environment.systemPackages = with pkgs; [
      nemo-with-extensions
    ];
  };

  flake.modules.homeManager.programs = {pkgs, ...}: {
    programs.yazi = {
      enable = true;
      shellWrapperName = "y";
    };
    stylix.targets.yazi.enable = true;

    xdg.desktopEntries.nemo = {
      name = "File Manager";
      exec = "${pkgs.nemo-with-extensions}/bin/nemo";
      icon = "nemo";
      genericName = "File Manager";
    };

    xdg.mimeApps.defaultApplications = {
      "inode/directory" = ["nemo.desktop"];
      "inode/mount-point" = ["nemo.desktop"]; # preservation makes some directories show up as mount points
      "application/x-gnome-saved-search" = ["nemo.desktop"];
    };

    home.file.".local/share/nemo/actions/vscode.nemo_action".text = ''
      [Nemo Action]
      Active=true
      Name=Open in VS Code
      Comment=Open Visual Studio Code in the current directory.
      Exec=code %P
      Icon-Name=com.visualstudio.code
      Selection=none
      Extensions=any;
      Quote=double
      Dependencies=code;
    '';

    # use dconf2nix to extract configured preferences
    dconf.settings = {
      "org/cinnamon/desktop/applications/terminal" = {
        # TODO: this should use xdg-terminal-exec instead, but have problems with this
        # and ghostty due to gtk-single-instance
        exec = "ghostty";
        exec-arg = "--window-inherit-working-directory=true";
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

      "org/nemo/desktop" = {
        show-desktop-icons = false;
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

    wayland.windowManager.hyprland.settings = {
      bind = [
        "$MOD, E, exec, app2unit -- nemo"
      ];

      windowrulev2 = [
        "float, class:nemo,title:^(.* Properties)"
      ];
    };
  };
}
