{
  flake.modules.homeManager.base = {pkgs, ...}: {
    stylix = {
      autoEnable = false;
      polarity = "dark";

      cursor = {
        package = pkgs.apple-cursor;
        name = "macOS";
        size = 20;
      };

      fonts = {
        monospace = {
          name = "FiraCode Nerd Font";
          package = pkgs.nerd-fonts.fira-code;
        };
        sansSerif = {
          name = "Fira Sans";
          package = pkgs.fira;
        };
        serif = {
          name = "Fira Sans";
          package = pkgs.fira;
        };
      };

      iconTheme = {
        enable = true;
        dark = "Papirus-Dark";
        light = "Papirus-Light";
        package = pkgs.papirus-icon-theme;
      };
    };
  };
}
