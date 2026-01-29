{
  flake.modules.homeManager.development = {pkgs, ...}: {
    # programs.reanix.extraConfig = {
    #   "reaper.ini" = ''
    #     ; Selected theme
    #     [reaper]
    #     lastthemefn5=${config.home.homeDirectory}/REAPER/ColorThemes/Reapertips.ReaperTheme
    #   '';
    # };

    xdg.configFile = {
      "REAPER/ColorThemes/Reapertips.ReaperThemeZip".source = pkgs.nur.repos.mrtnvgr.reapertips-dark.override {
        undimmed = true;
        colored_track_names = true;
      };

      "REAPER/libSwell-user.colortheme".source = ./libSwell-user.colortheme;

      "REAPER/Data/color_maps/default.png".source = pkgs.fetchurl {
        url = "https://i.imgur.com/Ca0JhRF.png";
        hash = "sha256-FSANQn2V4TjYUvNr4UV1qUhOSeUkT+gsd1pPj4214GY=";
      };
    };

    # required fonts for reapertips theme
    home.packages = with pkgs; [
      fira-sans
      roboto
    ];
  };
}
