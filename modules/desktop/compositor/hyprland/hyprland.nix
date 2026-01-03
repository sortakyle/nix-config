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
      NIXOS_OZONE_WL = 1;
      MOZ_ENABLE_WAYLAND = 1;
      MOZ_WEBRENDER = 1;

      # enable native Wayland support for most Electron apps
      ELECTRON_OZONE_PLATFORM_HINT = "auto";

      _JAVA_AWT_WM_NONREPARENTING = "1";
      QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
      QT_QPA_PLATFORM = "wayland";
      SDL_VIDEODRIVER = "wayland";
      XDG_SESSION_TYPE = "wayland";
      #GDK_BACKEND = "wayland";
    };

    wayland.windowManager.hyprland = {
      enable = true;

      # utilizing uwsm for systemd units
      systemd.enable = false;
    };
  };
}
