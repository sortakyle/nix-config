{inputs, ...}: let
  profile = "default";

  # Generated from
  # uuidgen --sha1 --namespace 630fcd67-0fe3-4d26-9998-ebd4f9179ab4 --name
  extensionsMap = {
    "uBlock0@raymondhill.net" = "f2dfe198-4359-520e-ad8d-dce5d072da82";
    "{d634138d-c276-4fc8-924b-40a0ea21d284}" = "fcd36c08-28c7-54aa-b16d-15b9b4f94e86";
  };
  # extensionUuidList = builtins.attrValues extensionsMap;
in {
  flake.modules.nixos.browser = {
    preserve.users = let
      # TODO: move to .config/mozilla once 147 lands in stable (Jan 2026?)
      prefix = ".mozilla/firefox/${profile}";
    in {
      # simplifying to just persiting the whole profile for now
      directories = ["${prefix}"];
      # directories = [
      #   # this will persist the IndexDB data for extensions + all sites visited
      #   # Alternative is is manually calculating the extension uuids and leveraging that.
      #   # I have a working version of this solution, but not sure if that is the best path forward
      #   "${prefix}/storage/default/"
      # ];

      # files = [
      #   "${prefix}/cookies.sqlite"
      #   "${prefix}/favicons.sqlite"
      #   "${prefix}/permissions.sqlite"
      #   "${prefix}/content-prefs.sqlite"
      #   "${prefix}/places.sqlite"
      #   "${prefix}/storage.sqlite"
      #   # These two files should not be necessary to persist and instead declaritively defined.
      #   # I have been unable to get a consistent solution for generating them
      #   "${prefix}/prefs.js"
      #   "${prefix}/extension-settings.json"
      # ];
    };

    # Overlay NUR to enable unfree firefox addons (1pass)
    nixpkgs.overlays = [inputs.nur.overlay];
  };

  flake.modules.homeManager.browser = {
    lib,
    pkgs,
    ...
  }: {
    home.sessionVariables = {
      BROWSER = lib.mkDefault "firefox";
    };

    xdg.mimeApps.defaultApplications = {
      "text/html" = ["firefox.desktop"];
      "text/xml" = ["firefox.desktop"];
      "x-scheme-handler/http" = ["firefox.desktop"];
      "x-scheme-handler/https" = ["firefox.desktop"];
    };

    programs.firefox = {
      enable = true;
      package = pkgs.firefox-bin;

      policies = {
        EnableTrackingProtection = {
          Value = true;
          Locked = true;
          Cryptomining = true;
          Fingerprinting = true;
        };
        HardwareAcceleration = true;
        FirefoxHome = {
          Search = false;
          TopSites = false;
          SponsoredTopSites = false;
          Highlights = false;
          Pocket = false;
          SponsoredPocket = false;
          Snippets = false;
          Locked = false;
        };
      };

      profiles.${profile} = {
        containersForce = true;

        # disable default search engines, make kagi default
        search = {
          force = true;
          default = "kagi";
          engines = {
            # don't need these default ones
            amazondotcom-us.metaData.hidden = true;
            bing.metaData.hidden = true;
            ebay.metaData.hidden = true;
            google.metaData.hidden = true;
            kagi = {
              name = "Kagi";
              urls = [{template = "https://kagi.com/search?q={searchTerms}";}];
              iconMapObj."32" = "https://kagi.com/favicon.ico";
              definedAliases = ["@k"];
            };
          };
        };

        extensions = {
          force = true;
          packages = with pkgs.nur.repos.rycee.firefox-addons; [
            ublock-origin
            onepassword-password-manager
          ];
        };

        settings = {
          # First launch
          "app.normandy.enabled" = false;
          "app.normandy.api_url" = "";
          "browser.aboutwelcome.enabled" = false;
          "browser.rights.3.shown" = false;

          # New tab page junk
          "browser.newtabpage.activity-stream.feeds.section.topstories" = false;
          "browser.newtabpage.activity-stream.feeds.weatherfeed" = false;
          "browser.newtabpage.activity-stream.showSponsored" = false;
          "browser.newtabpage.activity-stream.showSponsoredTopSites" = false;
          "browser.newtabpage.activity-stream.showWeather" = false;
          "browser.newtabpage.activity-stream.system.showSponsored" = false;
          "browser.newtabpage.activity-stream.system.showWeather" = false;
          "browser.newtabpage.activity-stream.weather.locationSearchEnabled" = false;

          # Search junk
          "browser.urlbar.scotchBonnet.enableOverride" = true;
          "browser.urlbar.suggest.topsites" = false;
          "browser.urlbar.suggest.trending" = false;
          "browser.urlbar.suggest.quicksuggest.nonsponsored" = false;
          "browser.urlbar.suggest.quicksuggest.sponsored" = false;
          "browser.urlbar.suggest.yelp" = false;

          # Addons junk
          "extensions.htmlaboutaddons.recommendations.enabled" = false;

          # Pocket junk
          "browser.urlbar.suggest.pocket" = false;
          "extensions.pocket.enabled" = false;

          # Prevent Firefox from warning before going to about:config
          "browser.aboutConfig.showWarning" = false;

          # Don't try to store passwords
          "signon.rememberSignons" = false;

          # Don't worry about missing session files (deleted via impermanence)
          "browser.sessionstore.max_resumed_crashes" = -1;

          # Prevent Firefox from suggesting to re-open tabs from last session
          "browser.startup.couldRestoreSession.count" = -1;

          # Default Ctrl-F to highlight all results by default
          "findbar.highlightAll" = true;

          # pre-configure extension UUIDs (allows persisting only extension IndexDBs)
          "extensions.webextensions.uuids" = extensionsMap;

          # auto-enable extensions
          "extensions.autoDisableScopes" = 0;
          "extensions.enabledScopes" = 15;
          "extensions.allowPrivateBrowsingByDefault" = true;
        };
      };
    };
  };
}
