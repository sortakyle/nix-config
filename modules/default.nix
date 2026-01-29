{
  inputs,
  importApply,
}: {
  flakeModules = {};

  nixosModules = rec {
    preserve = importApply ./preserve {inherit inputs;};

    all = [
      preserve
    ];
  };

  homeModules = {};
}
