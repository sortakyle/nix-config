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
        _hostname: host: let
          inherit (self) outputs;

          nixosModules =
            [
              config.flake.modules.nixos.modules # modules from this repo
              config.flake.modules.nixos.base # the base module
            ] # base module that applies to all hosts
            ++ host.modules # nixos modules imports
            ++ host.module.imports; # host specific module configuration

          users =
            lib.mapAttrs (_username: v: {
              imports =
                [
                  config.flake.modules.homeManager.base
                ] # base module that applies to all hosts
                ++ v.modules; # home-manager modules import for the givnen user
            })
            host.users;

          specialArgs =
            {
              inherit host outputs; # not passing inputs, get from flake-parts module params
            }
            // host.args;
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
                  home-manager.sharedModules = [
                    config.flake.modules.homeManager.modules # modules from this repo
                  ];
                }
              ];
          }
      )
      config.hosts.nixos;
  };
}
