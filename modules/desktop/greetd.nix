{
  flake.modules.nixos.desktop = {
    lib,
    pkgs,
    ...
  }: {
    services.greetd = {
      enable = true;
      # useTextGreeter = true;
      settings = {
        default_session = {
          command = "${lib.getExe pkgs.hyprland}";
          user = "kyle";
        };
      };
    };

    preserve.system.directories = ["/var/cache/tuigreet"];
  };
}
