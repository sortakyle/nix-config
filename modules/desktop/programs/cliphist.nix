{
  flake.modules.homeManager.desktop = {pkgs, ...}: {
    # By default, cliphist db is persited at $XDG_CACHE_HOME/cliphist/db
    # not persisting it for now, meaning all clipboard history is lost on reboot
    services.cliphist = {
      enable = true;
      allowImages = true;
    };

    home.packages = [
      (pkgs.writeShellScriptBin "chist" ''
        cliphist list | fzf --reverse | cliphist decode | wl-copy
      '')
    ];

    wayland.windowManager.hyprland.settings = {
      bind = [
        "$MOD, V, exec, ghostty --class=floating.ghostty --confirm-close-surface=false -e chist"
      ];
    };
  };
}
