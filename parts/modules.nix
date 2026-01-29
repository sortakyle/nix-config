{
  inputs,
  flake-parts-lib,
  ...
}: let
  inherit (flake-parts-lib) importApply;

  modules = import ./../modules {inherit inputs importApply;};
in {
  imports = modules.flakeModules.all;

  # TODO: Find a better way to inject nixos & homeManager modules
  flake.modules.nixos.modules = {
    imports = modules.nixosModules.all;
  };

  flake.modules.homeManager.modules = {
    imports = modules.homeModules.all;
  };
}
