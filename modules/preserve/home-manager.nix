{lib, ...}: let
  inherit (lib) mkOption types;
  inherit (types) submodule;
in {
  options = {
    home.preserve = mkOption {
      default = {};
      type = submodule (
        import ./submodule.nix {inherit lib;}
      );
    };
  };
}
