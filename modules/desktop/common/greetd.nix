{
  flake.modules.nixos.desktop = {
    lib,
    pkgs,
    config,
    ...
  }: {
    services.greetd = {
      enable = true;
      useTextGreeter = true;
      settings = {
        default_session = {
          command = "${lib.getExe pkgs.tuigreet} --time --sessions ${config.services.displayManager.sessionData.desktops}/share/wayland-sessions --remember --remember-user-session";
          user = "greeter";
        };
      };
    };
  };
}
