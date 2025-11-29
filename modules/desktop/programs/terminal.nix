{
  flake.modules.nixos.desktop = {pkgs, ...}: {
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

  flake.modules.homeManager.desktop = {
    programs.ghostty = {
      enable = true;
      settings = {
        "scrollback-limit" = 4294967295;
        # "window-decoration" = false;
        "window-padding-x" = 20;
        "window-padding-y" = 20;

        shell-integration-features = true;
        window-decoration = "server";
        window-padding-color = "extend";
        window-padding-balance = true;
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

    # Bindings for Hyprland compositor
    wayland.windowManager.hyprland.settings = {
      bind = [
        "$MOD, T, exec, app2unit -- ghostty"
        "$MOD, Return, exec, app2unit -- ghostty"
        "$MOD ALT, Return, exec, app2unit -- ghostty --class=floating.ghostty"
      ];

      windowrulev2 = [
        "float, class:floating.ghostty"
        "size 1200 700, class:floating.ghostty"
      ];
    };
  };
}
