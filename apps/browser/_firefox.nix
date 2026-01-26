{
  flake.modules.homeManager.browser = {
    inputs,
    pkgs,
    lib,
    ...
  }: {
    home.sessionVariables = {
      BROWSER = lib.mkDefault "firefox";
    };

    programs.firefox = {
      enable = true;
      package = inputs.firefox.packages.${pkgs.system}.firefox-nightly-bin;
      profiles.default = {
        id = 0;
        containersForce = true;
        containers = {};
      };
    };

    home.file.".mozilla/firefox/default/extension-settings.json" = {
      force = true;
      text = builtins.toJSON {
        version = 3;
        commands = {};
        url_overrides = {};
        prefs = {
          websites.hyperlinkAuditingEnabled = {
            initialValue = {};
            precedenceList = [
              {
                id = "uBlock0@raymondhill.net";
                installDate = 1000;
                value = false;
                enabled = true;
              }
            ];
          };
          network.networkPredictionEnabled = {
            initialValue = {
              network.predictor.enabled = false;
              network.prefetch-next = false;
              network.http.speculative-parallel-limit = 0;
              network.dns.disablePrefetch = true;
            };
            precedenceList = [
              {
                id = "uBlock0@raymondhill.net";
                installDate = 1000;
                value = false;
                enabled = true;
              }
            ];
          };
          services.passwordSavingEnabled = {
            initialValue = {};
            precedenceList = [
              {
                id = "{d634138d-c276-4fc8-924b-40a0ea21d284}";
                installDate = 1000;
                value = false;
                enabled = true;
              }
            ];
          };
        };
      };
    };

    home.file.".mozilla/native-messaging-hosts/com.1password.1password.json" = {
      force = true;
      text = builtins.toJSON {
        name = "com.1password.1password";
        description = "1Password BrowserSupport";
        path = "/run/wrappers/bin/1Password-BrowserSupport";
        type = "stdio";
        allowed_extensions = [
          "{0a75d802-9aed-41e7-8daa-24c067386e82}"
          "{25fc87fa-4d31-4fee-b5c1-c32a7844c063}"
          "{d634138d-c276-4fc8-924b-40a0ea21d284}"
        ];
      };
    };

    xdg.mimeApps.defaultApplications = {
      "text/html" = ["firefox.desktop"];
      "text/xml" = ["firefox.desktop"];
      "x-scheme-handler/http" = ["firefox.desktop"];
      "x-scheme-handler/https" = ["firefox.desktop"];
    };

    stylix.targets.firefox = {
      enable = true;
      profileNames = ["default"];
    };
  };

  flake.modules.nixos.browser = {
    # TODO: move to xdg with v147 (.config/mozilla/...)
    preserve.users.files = [
      ".mozilla/firefox/default/cookies.sqlite"
      ".mozilla/firefox/default/favicons.sqlite"
      ".mozilla/firefox/default/permissions.sqlite"
      ".mozilla/firefox/default/content-prefs.sqlite"
      ".mozilla/firefox/default/places.sqlite"
      ".mozilla/firefox/default/storage.sqlite"
    ];
  };
}
