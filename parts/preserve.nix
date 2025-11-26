# This module wraps https://github.com/nix-community/preservation to:
# 1. simplify syntax for defining preservation configuration
# 2. set a universal preserveAt directory which only needs to be declared once
# 3. leverages the hostConfig passed to flake.modules to configure multi-user persistence
#
# While it is in parts, it needs to be defined as a flake.module in order for it to be accessible
# by other flake.modules. This file should contain only boilerplate and the sister file in
# modules/base declares and specific base preservation configuration.
{inputs, ...}: {
  flake.modules.nixos.base = {
    lib,
    config,
    hostConfig,
    ...
  }: let
    cfg = config.preserve;

    settingsModule = lib.mkOption {
      type = with lib.types;
        submodule {
          options = {
            directories = lib.mkOption {
              type = listOf raw;
              default = [];
            };
            files = lib.mkOption {
              type = listOf raw;
              default = [];
            };
          };
        };

      default = {};
    };
  in {
    imports = [inputs.preservation.nixosModules.default];

    options.preserve = {
      enable = lib.mkEnableOption "Enables preservation";

      at = lib.mkOption {
        type = lib.types.str;
        default = "/persist";
      };

      system = settingsModule;
      users = settingsModule;
    };

    config = lib.mkIf cfg.enable {
      preservation.enable = cfg.enable;

      preservation.preserveAt.${cfg.at} = {
        inherit (cfg.system) directories;
        inherit (cfg.system) files;

        users =
          lib.mapAttrs (_: _: {
            commonMountOptions = [
              "x-gvfs-hide"
            ];

            inherit (cfg.users) directories;
            inherit (cfg.users) files;
          })
          hostConfig.users;
      };

      # TODO: figure out a good way to templatize the systemd.tmpfiles.settings.preservation
    };
  };
}
