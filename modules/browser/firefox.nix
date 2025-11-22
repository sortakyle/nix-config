{
  flake.modules.homeManager.browser = {
    pkgs,
    lib,
    ...
  }: {
    home.sessionVariables = {
      BROWSER = lib.mkDefault "firefox";
    };

    programs.firefox = {
      enable = true;
      package = pkgs.firefox-bin;
      profiles.default = {
        id = 0;
        extensions.force = lib.mkForce true;

        extraConfig = ''
          lockPref("extensions.activeThemeID", "{8446b178-c865-4f5c-8ccc-1d7887811ae3}");
          lockPref("extensions.formautofill.addresses.enabled", false);
          lockPref("extensions.formautofill.creditCards.enabled", false);
          lockPref("dom.security.https_only_mode_pbm", true);
          lockPref("dom.security.https_only_mode_error_page_user_suggestions", true);
          lockPref("browser.firefox-view.feature-tour", "{\"screen\":\"\",\"complete\":true}");
          lockPref("identity.fxaccounts.enabled", false);
          lockPref("browser.tabs.firefox-view-next", false);
          lockPref("privacy.sanitize.sanitizeOnShutdown", false);
          lockPref("privacy.clearOnShutdown.cache", true);
          lockPref("privacy.clearOnShutdown.cookies", false);
          lockPref("privacy.clearOnShutdown.offlineApps", false);
          lockPref("browser.sessionstore.privacy_level", 0);
          lockPref("floorp.browser.sidebar.enable", false);
          lockPref("geo.enabled", false);
          lockPref("media.navigator.enabled", false);
          lockPref("dom.event.clipboardevents.enabled", false);
          lockPref("dom.event.contextmenu.enabled", false);
          lockPref("dom.battery.enabled", false);
          lockPref("extensions.enabledScopes", 15);
          lockPref("extensions.autoDisableScopes", 0);
          lockPref("browser.newtabpage.activity-stream.floorp.newtab.imagecredit.hide", true);
          lockPref("browser.newtabpage.activity-stream.floorp.newtab.releasenote.hide", true);
          lockPref("browser.search.separatePrivateDefault", true);
        '';
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
      colorTheme.enable = true;
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
