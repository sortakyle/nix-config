{
  flake.modules.homeManager.gaming = {pkgs, ...}: {
    home.packages = with pkgs; [
      moonlight-qt
    ];

    # Create my own custom desktop entry for moonlight that uses PulseAudio instead of system default
    # this is necessary for discord stream to pick up the audio. Discord only recognizes audio
    # from PulseAudio sources, not pipewire native even when using pipewire
    xdg.desktopEntries = {
      "com.moonlight_stream.Moonlight" = {
        name = "Moonlight";
        comment = "Stream games and other applications from another PC running Sunshine or GeForce Experience";
        exec = "env SDL_AUDIODRIVER=pulse moonlight";
        icon = "moonlight";
        terminal = false;
        type = "Application";
        categories = ["Qt" "Game"];
      };
    };

    # Hyprland configuration options + bindings
    wayland.windowManager.hyprland.settings = {
      windowrule = [
        "idle_inhibit fullscreen, match:class com.moonlight_stream.Moonlight"
      ];
    };

    home.preserve.files = [".config/Moonlight Game Streaming Project/Moonlight.conf"];
  };
}
