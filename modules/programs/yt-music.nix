{
  flake.modules.homeManager.programs = {pkgs, ...}: {
    home.packages = with pkgs; [
      pear-desktop
    ];

    wayland.windowManager.hyprland.settings = {
      windowrulev2 = let
        class = "com.github.th_ch.youtube_music";
      in [
        "float, class:${class}"
        "animation popout, class:${class}"
      ];
    };
  };

  flake.modules.nixos.programs = {
    preserve.users.directories = [".config/YouTube Music"];
  };
}
