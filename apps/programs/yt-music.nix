{
  flake.modules.homeManager.programs = {pkgs, ...}: {
    home.packages = with pkgs; [
      pear-desktop
    ];

    wayland.windowManager.hyprland.settings = {
      windowrule = [
        "float on, animation popout, match:class com.github.th_ch.youtube_music"
      ];
    };

    home.preserve.directories = [".config/YouTube Music"];
  };
}
