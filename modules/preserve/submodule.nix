{lib, ...}: let
  inherit (lib) mkOption types;
  inherit (types) listOf raw;
in {
  options = {
    directories = mkOption {
      type = listOf raw;
      default = [];
    };
    files = mkOption {
      type = listOf raw;
      default = [];
    };
  };
}
