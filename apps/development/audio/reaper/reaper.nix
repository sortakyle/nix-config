{
  flake.modules.homeManager.development = {pkgs, ...}: {
    # imports = [inputs.reanix.homeModules.default];

    home.packages = with pkgs; [
      reaper
    ];

    xdg.configFile."REAPER" = {
      source = pkgs.symlinkJoin {
        name = "reaper-extensions";
        paths = with pkgs; [
          reaper-sws-extension
          reaper-reapack-extension
        ];
      };
      recursive = true;
      force = true;
    };

    # programs.reanix = {
    #   enable = true;

    #   # extensions = {
    #   #   realearn.enable = true;
    #   #   reapack.enable = true;
    #   #   sws.enable = true;
    #   # };

    #   options = {
    #     default_track_height = "small";

    #     # Clean Items
    #     display_media_item_take_name = false;
    #     draw_labels_above_the_item.enable = false;
    #     item_icons.min_height = 90;

    #     continuous_scrolling = true;

    #     # Save renders in the project directory
    #     paths.renders = "Renders";
    #   };
    # };
  };
}
