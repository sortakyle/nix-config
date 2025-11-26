{
  flake.modules.homeManager.desktop-simple = {inputs, ...}: {
    imports = [inputs.walker.homeManagerModules.default];

    programs.walker = {
      enable = true;
      runAsService = true;
      config = {
        theme = "nixos";
        providers = {
          default = [
            "desktopapplications"
            "calc"
            "menus"
          ];
          prefixes = [
            {
              provider = "bluetooth";
              prefix = "&";
            }
            {
              provider = "files";
              prefix = "/";
            }
            {
              provider = "providerlist";
              prefix = "_";
            }
            {
              provider = "runner";
              prefix = "$";
            }
            {
              provider = "symbols";
              prefix = ":";
            }
            {
              provider = "todo";
              prefix = "!";
            }
            {
              provider = "unicode";
              prefix = "%";
            }
            {
              provider = "websearch";
              prefix = "@";
            }
          ];
        };
        elephant = {
          installService = true;
        };
      };
    };

    programs.elephant = {
      enable = true;
      installService = true;
      provider = {
        websearch.settings = {
          entries = [
            {
              default = true;
              name = "Kagi";
              url = "https://kagi.com/?q=%TERM%";
            }
            {
              name = "NixOS Options";
              url = "https://search.nixos.org/options?channel=unstable&query=%TERM%";
            }
            {
              name = "NixOS Packages";
              url = "https://search.nixos.org/packages?channel=unstable&query=%TERM%";
            }
            {
              name = "Home Manager Options";
              url = "https://home-manager-options.extranix.com/?release=master&query=%TERM%";
            }
            {
              name = "Searchix";
              url = "https://searchix.ovh/?query=%TERM%";
            }
          ];
        };
      };
    };
  };

  flake.modules.nixos.desktop-simple = {
    preserve.users.directories = [".cache/elephant/"];
  };
}
