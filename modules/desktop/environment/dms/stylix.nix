{inputs, ...}: {
  flake.modules.homeManager.desktop-dms = {pkgs, ...}: {
    stylix = {
      enable = true;
      polarity = "dark";

      base16Scheme = "${inputs.tinted-schemes}/base24/catppuccin-mocha.yaml";

      cursor = {
        package = pkgs.bibata-cursors;
        name = "Bibata-Modern-Ice";
        size = 24;
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
