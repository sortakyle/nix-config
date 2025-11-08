{lib, ...}: {
  options.hosts.nixos = lib.mkOption {
    type = lib.types.lazyAttrsOf (
      lib.types.submodule {
        options = lib.mkOption {
          type = lib.types.deferredModule;
          default = {};
        };
      }
    );
  };

  config = { };
}