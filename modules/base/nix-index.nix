{inputs, ...}: {
  flake.modules = {
    nixos.base = {
      imports = [inputs.nix-index-database.nixosModules.nix-index];

      programs.command-not-found.enable = false;
      programs.nix-index-database.comma.enable = true;
    };

    homeManager.base = {
      imports = [inputs.nix-index-database.homeModules.nix-index];

      programs.command-not-found.enable = false;
      programs.nix-index-database.comma.enable = true;
      programs.nix-index.enable = true;
    };
  };
}
