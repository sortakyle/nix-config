{
  flake.modules.homeManager.messaging = {
    programs.discord.enable = true;

    # Startup logic and window rules for hyprland compositor
    wayland.windowManager.hyprland.settings = {
      exec-once = [
        "sleep 1 && app2unit -- discord"
      ];

      windowrulev2 = [
        "float, class:discord"
        "size 2000 1200, class:discord"
      ];
    };
  };

  flake.modules.nixos.messaging = {
    preserve.users.directories = [
      ".config/vesktop"
      ".config/discord"
    ];
  };
}
