{
  inputs,
  importApply,
}: {
  flakeModules = {
    all = [];
  };

  nixosModules = rec {
    preserve = importApply ./preserve {inherit inputs;};

    all = [
      preserve
    ];
  };

  homeModules = {
    all = [];
  };
}
