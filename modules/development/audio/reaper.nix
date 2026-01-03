{
  flake.modules.homeManager.development = {
    pkgs,
    lib,
    config,
    ...
  }: {
    home.packages = with pkgs; [
      reaper

      # Audio plugins (LV2, VST2, VST3, LADSPA)
      # distrho-ports
      dexed
      surge
      # calf
      eq10q
      # lsp-plugins
      dragonfly-reverb
      # guitarix
      # geonkick

      # broken, should be fixed in ~24 hrs https://github.com/NixOS/nixpkgs/pull/476467
      # yabridge
      # yabridgectl
    ];

    xdg.configFile."REAPER" = {
      source = pkgs.symlinkJoin {
        name = "reaper-extensions";
        paths = with pkgs; [
          reaper-sws-extension
          reaper-reapack-extension
        ];
      };
      recursive = true;
      force = true;
    };

    home.sessionVariables = let
      makePluginPath = format:
        "${config.home.homeDirectory}/.${format}:"
        + (lib.makeSearchPath format [
          "/etc/profiles/per-user/${config.home.username}/lib"
          "/run/current-system/sw/lib"
        ]);
    in {
      VST_PATH = makePluginPath "vst";
      VST3_PATH = makePluginPath "vst3";
    };
  };

  flake.modules.nixos.development = {
    preserve.users.directories = [
      ".config/REAPER"
      ".vst"
      ".vst3"
    ];
  };
}
