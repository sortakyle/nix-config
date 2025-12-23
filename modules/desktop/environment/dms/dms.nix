{inputs, ...}: {
  flake.modules.nixos.desktop-dms = {
    preserve.users.directories = [
      ".config/DankMaterialShell"
    ];
  };

  flake.modules.homeManager.desktop-dms = {
    imports = [inputs.dankMaterialShell.homeModules.dankMaterialShell.default];

    home.sessionVariables = {
      DMS_HIDE_TRAYIDS = "copyq";
    };

    programs.dankMaterialShell = {
      enable = true;

      systemd = {
        enable = true;
        restartIfChanged = true;
      };

      enableSystemMonitoring = true;
      enableClipboard = true;
      enableVPN = false;
      enableBrightnessControl = false;
      enableColorPicker = false;
      enableDynamicTheming = false;
      enableAudioWavelength = true;
      enableCalendarEvents = false;
      enableSystemSound = true;
    };
  };
}
