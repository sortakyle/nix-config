{
  flake.modules.nixos.desktop = {
    programs.hyprland = {
      enable = true;
      withUWSM = true;
      xwayland.enable = true;
    };
  };

  flake.modules.homeManager.desktop = {pkgs, ...}: {
    home.sessionVariables = {
      MOZ_ENABLE_WAYLAND = 1;
      QT_QPA_PLATFORM = "wayland";
      SDL_VIDEODRIVER = "wayland";
      XDG_SESSION_TYPE = "wayland";
    };

    wayland.windowManager.hyprland = {
      enable = true;
      package = null;
      portalPackage = null;

      # utilizing uwsm for systemd units
      systemd.enable = false;
    };

    # TODO: temporary
    programs.kitty.enable = true;
    programs.firefox = {
      enable = true;
      package = pkgs.firefox-bin;
    };
  };
}
