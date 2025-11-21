{inputs, ...}: {
  imports = [
    inputs.git-hooks.flakeModule
    inputs.make-shell.flakeModules.default
  ];

  perSystem = {config, ...}: {
    pre-commit.check.enable = true;
    make-shells.default.shellHook = config.pre-commit.shellHook;
  };
}
