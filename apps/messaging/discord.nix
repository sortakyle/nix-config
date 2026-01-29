{
  flake.modules.homeManager.messaging = {
    programs.discord.enable = true;

    # Startup logic and window rules for hyprland compositor
    wayland.windowManager.hyprland.settings = {
      exec-once = [
        "sleep 1 && app2unit -- discord"
      ];

      windowrule = [
        "float on, size 2000 1200, match:class discord"
      ];
    };

    home.preserve.directories = [".config/discord"];
  };
}
