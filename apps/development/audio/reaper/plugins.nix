{
  flake.modules.homeManager.development = {
    pkgs,
    config,
    ...
  }: let
    make = format:
      (pkgs.lib.concatStringsSep ":" [
        "${config.home.homeDirectory}/.${format}"
        "/etc/profiles/per-user/${config.home.username}/lib/${format}"
        "${config.home.homeDirectory}/.nix-profile/lib/${format}"
        "/run/current-system/sw/lib/${format}"
      ])
      + ":";
  in {
    home.packages = with pkgs; [
      # Synths
      vital

      # FX
    ];

    home.sessionVariables = {
      VST3_PATH = make "vst3";
      VST_PATH = make "vst";
      CLAP_PATH = make "clap";
      LV2_PATH = make "lv2";
      LADSPA_PATH = make "ladspa";
    };
  };

  flake.modules.nixos.development = {
    preserve.users.directories = [
      ".local/share/vital"
    ];
  };
}
