{
  flake.modules.homeManager.messaging = {
    programs.vesktop = {
      enable = true;
    };

    # Startup logic and window rules for hyprland compositor
    wayland.windowManager.hyprland.settings = {
      exec-once = [
        "app2unit -- vesktop"
      ];

      windowrulev2 = [
        "float, class:vesktop"
        "size 2000 1200, class:vesktop"
      ];
    };
  };

  flake.modules.nixos.messaging = {
    preserve.users.directories = [".config/vesktop"];
  };
}
