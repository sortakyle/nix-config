{
  nixConfig = {
    abort-on-warn = true;
    allow-import-from-derivation = false;
  };

  inputs = {
    flake-parts.url = "github:hercules-ci/flake-parts";
    import-tree.url = "github:vic/import-tree";

    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-25.05";
    systems.url = "github:nix-systems/default-linux";
  };

  outputs = {flake-parts, import-tree, ...} @ inputs:
    flake-parts.lib.mkFlake {inherit inputs;} (
      inputs.import-tree [
        ./parts
        ./hosts
        ./modules
      ]
    );
}
