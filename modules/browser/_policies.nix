{
  flake.modules.homeManager.browser = {
    programs.firefox.policies = {
      AllowFileSelectionDialogs = true;
      AppAutoUpdate = false;
      AutofillAddressEnabled = false;
      AutofillCreditCardEnabled = false;
      AppUpdateURL = "https://localhost";
      #AutoLaunchProtocolsFromOrigins = { };
      BackgroundAppUpdate = false;
      BlockAboutAddons = false;
      BlockAboutConfig = false;
      BlockAboutProfiles = false;
      BlockAboutSupport = false;
      #Containers = { };
      DisableAppUpdate = true;
      DisableAccounts = true;
      DisableFirefoxAccounts = true;
      DisableFirefoxScreenshots = true;
      DisableFirefoxStudies = true;
      DisableFormHistory = true;
      DisableMasterPasswordCreation = true;
      DisablePocket = true;
      DisablePrivateBrowsing = false;
      DisableProfileImport = false;
      DisableProfileRefresh = false;
      DisableSafeMode = false;
      DisableTelemetry = true;
      DisableFeedbackCommands = true;
      DontCheckDefaultBrowser = true;
      # DNSOverHTTPS = {
      #   Enabled = true;
      # };
      EnableTrackingProtection = {
        Value = true;
        Locked = true;
        Cryptomining = true;
        Fingerprinting = true;
      };
      EncryptedMediaExtensions = {
        Enabled = true;
      };
      ExtensionUpdate = true;
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
      HardwareAcceleration = true;
      ManualAppUpdateOnly = true;
      NoDefaultBookmarks = false;
      OfferToSaveLogins = false;
      PasswordManagerEnabled = false;
      PictureInPicture = {
        Enabled = true;
      };
      PopupBlocking = {
        Allow = [];
        Default = true;
      };
      Preferences = {
        "browser.tabs.warnOnClose" = {
          Value = false;
        };
      };
      PromptForDownloadLocation = true;
      SearchSuggestEnabled = false;
      ShowHomeButton = false;
      StartDownloadsInTempDirectory = false;
      UserMessaging = {
        ExtensionRecommendations = false;
        SkipOnboarding = true;
      };
      Extensions = {
        Uninstall = [
          "google@search.mozilla.org"
          "bing@search.mozilla.org"
          "amazondotcom@search.mozilla.org"
          "ebay@search.mozilla.org"
          "twitter@search.mozilla.org"
        ];
      };
      ExtensionSettings = {
        "*" = {
          blocked_install_message = "Addon is not added in the nix config";
          installation_mode = "blocked";
        };
        # 1Password:
        "{d634138d-c276-4fc8-924b-40a0ea21d284}" = {
          private_browsing = true;
          default_area = "navbar";
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/1password-x-password-manager/latest.xpi";
          installation_mode = "force_installed";
        };
        "uBlock0@raymondhill.net" = {
          private_browsing = true;
          default_area = "navbar";
          installation_mode = "force_installed";
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/ublock-origin/latest.xpi";
        };
      };
    };
  };
}
