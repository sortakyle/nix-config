{
  flake.modules.nixos.desktop-hyprland = {pkgs, ...}: {
    programs.hyprland = {
      enable = true;
      withUWSM = true;
      xwayland.enable = true;
    };

    environment.systemPackages = with pkgs; [
      app2unit
    ];
  };

  flake.modules.homeManager.desktop-hyprland = {
    home.sessionVariables = {
      MOZ_ENABLE_WAYLAND = 1;
      QT_QPA_PLATFORM = "wayland";
      SDL_VIDEODRIVER = "wayland";
      XDG_SESSION_TYPE = "wayland";
      ELECTRON_OZONE_PLATFORM_HINT = "auto";
    };

    wayland.windowManager.hyprland = {
      enable = true;

      # utilizing uwsm for systemd units
      systemd.enable = false;

      settings = {
        bind = [
          "$MOD, T, exec, app2unit -- ghostty"
        ];

        bindr = [
          "$MOD, Super_L, exec, dms ipc call spotlight toggle"
        ];

        layerrule = [
          "animation popin, (osd-.*)"
          "abovelock, (osd-.*)"
          "noanim, ^(dms)$"
        ];

        windowrulev2 = [
          # "opacity 0.9 0.9, floating:0, focus:0"
          "idleinhibit fullscreen, class:^(firefox)$"
          "float, class:^(org.quickshell)$"
        ];
      };
    };
  };
}
