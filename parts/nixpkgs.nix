{
  inputs,
  withSystem,
  ...
}: {
  imports = [inputs.pkgs-by-name-for-flake-parts.flakeModule];

  perSystem = {system, ...}: {
    _module.args.pkgs = import inputs.nixpkgs {
      inherit system;
      config = {
        allowUnfreePredicate = _pkg: true;
      };
      overlays = [
        inputs.nur.overlays.default
      ];
    };
    pkgsDirectory = ../pkgs;
  };

  flake = {
    overlays.default = final: prev: {
      local = withSystem prev.stdenv.hostPlatform.system ({config, ...}: config.packages);
      inherit (inputs.nur.overlays.default final prev) nur;
    };
  };
}
