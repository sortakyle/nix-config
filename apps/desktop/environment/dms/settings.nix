{
  flake.modules.homeManager.desktop-dms = {
    programs.dank-material-shell.settings = {
      # dark theme, Catppuccin Mauve
      # Can do custom themes, but need to map base16 theme to mutagen theme
      theme = "dark";
      currentThemeName = "cat-mauve";
      customThemeFile = "";
      mutagenScheme = "scheme-tonal-spot";
      widgetColorMode = "colorful";
      widgetBackgroundColor = "sch";
      cornerRadius = 12; # widget corner radius
      modalDarkenBackground = false;

      # Transparency
      popupTransprency = 1;
      dockTransparency = 1;
      widgetTransparency = 1;

      # Widget Settings
      use24HourClock = false;
      showSeconds = false;
      useFahrenheit = true; # for weather widget, not CPU/GPU temp
      showWorkspaceSwitcher = true;
      showWeather = true;
      showMusic = true;
      showClipboard = true;
      showFocusedWindow = true;
      showCpuUsage = true;
      showMemUsage = true;
      showCpuTemp = true;
      showGpuTemp = true;
      showSystemTray = true;
      showClock = true;
      showNotificationButton = true;
      showBattery = true;
      showControlCenterButton = true;
      showCapsLockIndicator = true;
      waveProgressEnabled = true;
      clockCompactMode = false;
      hideBrightnessSlider = true;

      # What the button for control center shows (all false == settings cog)
      controlCenterShowAudioIcon = false;
      controlCenterShowNetworkIcon = false;
      controlCenterShowBluetoothIcon = false;
      controlCenterShowVpnIcon = false;
      controlCenterShowBrightnessIcon = false;
      controlCenterShowMicIcon = false;
      controlCenterShowBatteryIcon = false;
      controlCenterShowPrinterIcon = false;

      # What is shown in the control center
      controlCenterWidgets = [
        {
          id = "volumeSlider";
          enabled = true;
          width = 100;
        }
        {
          id = "audioOutput";
          enabled = true;
          width = 50;
        }
        {
          id = "audioInput";
          enabled = true;
          width = 50;
        }
        {
          id = "diskUsage";
          enabled = true;
          width = 50;
        }
        {
          id = "wifi";
          enabled = true;
          width = 50;
        }
      ];

      # Workspace Switcher Settings
      showWorkspaceIndex = false;
      showWorkspacePadding = true;
      workspaceScrolling = false;
      showWorkspaceApps = false;
      maxWorkspaceIcons = 3;
      workspacesPerMonitor = true;
      showOccupiedWorkspacesOnly = false;

      # Focused apps & all apps on workspace widgets
      focusedWindowCompactMode = false;
      runningAppsCompactMode = true;
      runningAppsCurrentWorkspace = true;
      runningAppsGroupByApp = false;

      # App Launcher settings
      appLauncherViewMode = "list";
      spotlightModalViewMode = "list";
      sortAppsAlphabetically = false;
      appLauncherGridColumns = 4;
      launcherLogoMode = "apps";
      launchPrefix = "app2unit";

      # Weather Settings
      weatherLocation = "Marysville, Washington";
      weatherCoordinates = "48.0517429,-122.1768209";
      useAutoLocation = false;
      weatherEnabled = true;

      powerMenuActions = [
        "reboot"
        "logout"
        "poweroff"
        "lock"
      ];

      osdAlwaysShowValue = false; # whether to show percentages
      osdPosition = 4; # top center

      notificationPopupPosition = 3; # bottom right

      # Where to show certain UI elements
      # TODO: this is host specific
      screenPreferences = {
        osd = ["all"];
        notifications = [
          {
            name = "DP-2";
            # model = "PG32UCDM";
          }
        ];
        toast = [
          {
            name = "DP-2";
            # model = "PG32UCDM";
          }
        ];
        systemTray = ["all"];
        wallpaper = []; # Do not use DMS for wallpaper management, use something else instead
      };

      # Bars that show up on the UI
      barConfigs = [
        # Bottom Bar, only shows on main monitor
        {
          id = "default";
          name = "Main Bar";
          enabled = true;
          position = 1; # bottom
          screenPreferences = [
            {
              name = "DP-2";
              # model = "PG32UCDM";
            }
          ];
          leftWidgets = [
            {
              id = "controlCenterButton";
              enabled = true;
            }
            {
              id = "cpuTemp";
              enabled = true;
              minimumWidth = true;
            }
          ];
          centerWidgets = [
            {
              id = "music";
              enabled = true;
              mediaSize = 2;
            }
          ];
          rightWidgets = [
            {
              id = "systemTray";
              enabled = true;
            }
            {
              id = "clock";
              enabled = true;
            }
            {
              id = "notificationButton";
              enabled = true;
            }
          ];
          spacing = 0;
          innerPadding = 8;
          bottomGap = 0;
          transparency = 1;
          widgetTransparency = 0;
          squareCorners = false;
          noBackground = false;
          gothCornersEnabled = true;
          borderEnabled = false;
          widgetOutlineEnabled = false;
          autoHide = false;
          fontScale = 1;
          visible = true;
          popupGapsAuto = true;
          popupGapsManual = 4;
          gothCornerRadiusOverride = true;
          gothCornerRadiusValue = 8;
          borderOpacity = 0;
          borderThickness = 1;
          widgetOutlineOpacity = 1;
        }
        # Top Bar, shows on all screens
        {
          id = "bar1764279703391";
          name = "Bar 2";
          enabled = true;
          position = 0; # top
          screenPreferences = ["all"];
          leftWidgets = [
            {
              id = "focusedWindow";
              enabled = true;
              focusedWindowCompactMode = false;
            }
          ];
          centerWidgets = [
            {
              id = "workspaceSwitcher";
              enabled = true;
            }
          ];
          rightWidgets = [
            {
              id = "runningApps";
              enabled = true;
              runningAppsCompactMode = false;
            }
          ];
          spacing = 0;
          innerPadding = 12;
          bottomGap = -4;
          transparency = 0;
          widgetTransparency = 1;
          squareCorners = true;
          noBackground = false;
          gothCornersEnabled = false;
          borderEnabled = false;
          widgetOutlineEnabled = false;
          autoHide = false;
          visible = true;
          popupGapsAuto = true;
          popupGapsManual = 4;
        }
      ];
    };
  };
}
