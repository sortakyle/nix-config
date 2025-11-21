{lib, ...}: let
  monitorOptions = lib.types.submodule {
    options = {
      name = lib.mkOption {
        type = lib.types.str;
        example = "DP-1";
      };
      primary = lib.mkOption {
        type = lib.types.bool;
        default = false;
      };
      width = lib.mkOption {
        type = lib.types.int;
        example = 1920;
      };
      height = lib.mkOption {
        type = lib.types.int;
        example = 1080;
      };
      refreshRate = lib.mkOption {
        type = lib.types.int;
        default = 60;
      };
      x = lib.mkOption {
        type = lib.types.int;
        default = 0;
      };
      y = lib.mkOption {
        type = lib.types.int;
        default = 0;
      };
      enabled = lib.mkOption {
        type = lib.types.bool;
        default = true;
      };
      transform = lib.mkOption {
        type = lib.types.int;
        default = 0;
        description = ''
          normal (no transforms) -> 0
          90 degrees -> 1
          180 degrees -> 2
          270 degrees -> 3
          flipped -> 4
          flipped + 90 degrees -> 5
          flipped + 180 degrees -> 6
          flipped + 270 degrees -> 7
        '';
      };
      workspaces = lib.mkOption {
        type = lib.types.listOf lib.types.str;
        default = [];
        description = ''
          Names of workspaces to initialize on the montior on login.
        '';
      };
    };
  };
in {
  hosts.options.monitors = lib.mkOption {
    type = lib.types.listOf monitorOptions;
    default = [];
  };
}
