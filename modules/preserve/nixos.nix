{
  lib,
  config,
  host,
  options,
  ...
}: let
  inherit
    (lib)
    mkOption
    mkEnableOption
    types
    mapAttrs
    flatten
    mkMerge
    mkIf
    ;
  inherit
    (types)
    submodule
    str
    ;

  cfg = config.preserve;

  settingsModule = mkOption {
    default = {};
    type = submodule (
      import ./submodule.nix {inherit lib;}
    );
  };

  homeManagerUsers = mapAttrs (_name: value:
    value.home.preserve or {})
  config.home-manager.users or {};

  # TODO: change this syntax to be defining per user instead of global
  # Should remove dependency on host as input
  nixosUsers =
    mapAttrs (_name: _value: {
      inherit (cfg.users) directories;
      inherit (cfg.users) files;
    })
    host.users;

  userConfig = builtins.zipAttrsWith (_user: userConfigs:
    builtins.zipAttrsWith (_: flatten) userConfigs)
  [nixosUsers homeManagerUsers];
in {
  options.preserve = {
    enable = mkEnableOption "Enables preservation";

    at = mkOption {
      type = str;
      default = "/persist";
    };

    system = settingsModule;
    users = settingsModule;
  };

  config = mkMerge [
    (lib.optionalAttrs (options ? home-manager.sharedModules) {
      home-manager.sharedModules = [
        ./home-manager.nix
      ];
    })
    (mkIf cfg.enable {
      preservation.enable = cfg.enable;
      preservation.preserveAt.${cfg.at} = {
        inherit (cfg.system) directories;
        inherit (cfg.system) files;

        users =
          mapAttrs (_name: value: {
            commonMountOptions = [
              "x-gvfs-hide"
            ];

            inherit (value) directories;
            inherit (value) files;
          })
          userConfig;
      };
    })
  ];
}
