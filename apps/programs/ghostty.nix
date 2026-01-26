{
  flake.modules.nixos.programs = {pkgs, ...}: {
    xdg.terminal-exec = {
      enable = true;
      package = pkgs.xdg-terminal-exec;
      settings = let
        terminal = [
          "com.mitchellh.ghostty.desktop"
        ];
      in {
        GNOME =
          terminal
          ++ [
            "com.raggesilver.BlackBox.desktop"
            "org.gnome.Terminal.desktop"
          ];
        default = terminal;
      };
    };
  };

  flake.modules.homeManager.programs = {
    programs.ghostty = {
      enable = true;
      settings = {
        "scrollback-limit" = 4294967295;
        "window-padding-x" = 20;
        "window-padding-y" = 20;

        shell-integration-features = true;
        window-decoration = "server";
        window-padding-color = "extend";
        window-padding-balance = true;
        window-inherit-working-directory = true;
        working-directory = "inherit";
        gtk-single-instance = false;
      };
    };

    stylix.targets.ghostty.enable = true;

    xdg.mimeApps = {
      associations.added = {
        "x-scheme-handler/terminal" = "com.mitchellh.ghostty.desktop";
      };
      defaultApplications = {
        "x-scheme-handler/terminal" = "com.mitchellh.ghostty.desktop";
      };
    };
  };
}
