{
  lib,
  config,
  inputs,
  self,
  ...
}: {
  options.hosts.nixos = lib.mkOption {
    type = lib.types.attrsOf (
      lib.types.submodule (
        {name, ...}: let
          inherit (lib) mkOption types;

          modules = mkOption {
            type = types.listOf types.deferredModule;
            default = [];
          };
        in {
          options =
            config.hosts.options
            // {
              inherit modules;
              name = mkOption {
                default = name;
                readOnly = true;
              };
              args = mkOption {
                type = types.lazyAttrsOf types.raw;
                default = {};
              };
              users = mkOption {
                type = types.lazyAttrsOf (
                  types.submodule {
                    options = {inherit modules;};
                  }
                );
                default = {};
              };
              module = mkOption {
                type = types.deferredModule;
                default = {};
              };
            };
        }
      )
    );
  };

  config = {
    flake.nixosConfigurations =
      lib.mapAttrs (
        _hostname: hostConfig: let
          inherit (self) outputs;

          nixosModules =
            [
              config.flake.modules.nixos.base
            ] # base module that applies to all hosts
            ++ hostConfig.modules # nixos modules imports
            ++ hostConfig.module.imports; # host specific module configuration

          users =
            lib.mapAttrs (_username: v: {
              imports =
                [
                  config.flake.modules.homeManager.base
                ] # base module that applies to all hosts
                ++ v.modules; # home-manager modules import for the givnen user
            })
            hostConfig.users;

          specialArgs =
            {
              inherit hostConfig inputs outputs;
            }
            // hostConfig.args;
        in
          inputs.nixpkgs.lib.nixosSystem {
            inherit specialArgs;
            modules =
              nixosModules
              ++ [
                inputs.home-manager.nixosModules.home-manager
                {
                  home-manager.extraSpecialArgs = specialArgs;
                  home-manager.useGlobalPkgs = true;
                  home-manager.useUserPackages = true;
                  home-manager.users = users;
                }
              ];
          }
      )
      config.hosts.nixos;
  };
}
