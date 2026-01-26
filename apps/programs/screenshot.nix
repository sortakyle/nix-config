{
  flake.modules.homeManager.programs = {pkgs, ...}: {
    home.packages = with pkgs; [
      grim
      grimblast
      slurp
      hyprpicker
      stable.wl-screenrec
    ];

    # Hyprland configuration options + bindings
    wayland.windowManager.hyprland.settings = {
      bind = [
        ", Print, exec, grimblast --notify copysave screen"
        "ALT, Print, exec, grimblast --notify copysave output"
        "$MOD, S, exec, grimblast copy area"
        "$MOD SHIFT, S, exec, grimblast --notify copysave area"
      ];
    };
  };
}
