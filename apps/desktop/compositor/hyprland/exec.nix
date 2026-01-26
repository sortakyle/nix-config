{
  flake.modules.homeManager.desktop-hyprland = {
    wayland.windowManager.hyprland.settings = {
      exec-once = [
        # Goal is to keep this empty. Anything that we want to run on startup should instead
        # setup and use systemd which will also have the advantage of improved startup order.
        # Leaving this here in the event we need to add exec-once entries in the future
      ];
    };
  };
}
