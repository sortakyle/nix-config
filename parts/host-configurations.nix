{lib, config, inputs, self, ...}: {
  options.hosts.nixos = lib.mkOption {
    type = lib.types.lazyAttrsOf (
      lib.types.submodule {
        options.module = lib.mkOption {
          type = lib.types.deferredModule;
        };
      }
    );
  };

  config.flake = let
    inherit (inputs.nixpkgs) lib;
    inherit (self) outputs;
    specialArgs = {inherit inputs outputs;};
  in  {
    nixosConfigurations = lib.flip lib.mapAttrs config.hosts.nixos (
      name: { module }: lib.nixosSystem {
        inherit specialArgs;
        modules = [ module ];
      }
    );
  };
}