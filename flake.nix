{
  nixConfig = {
    # TODO: reenable once vscode-extensions fixes warning
    # abort-on-warn = true;
    allow-import-from-derivation = false;
  };

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-25.11";
    systems.url = "github:nix-systems/default-linux";

    flake-parts = {
      url = "github:hercules-ci/flake-parts";
      inputs.nixpkgs-lib.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    git-hooks = {
      url = "github:cachix/git-hooks.nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    preservation.url = "github:nix-community/preservation";
    import-tree.url = "github:vic/import-tree";
    treefmt-nix.url = "github:numtide/treefmt-nix";
    make-shell.url = "github:nicknovitski/make-shell";
    nixos-facter-modules.url = "github:numtide/nixos-facter-modules";

    lazy-apps = {
      url = "sourcehut:~rycee/lazy-apps";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-index-database = {
      url = "github:nix-community/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    stylix = {
      url = "github:nix-community/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    catppuccin = {
      url = "github:catppuccin/nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    tinted-schemes = {
      url = "github:tinted-theming/schemes";
      flake = false;
    };

    elephant = {
      url = "github:abenz1267/elephant";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    walker = {
      url = "github:abenz1267/walker";
      inputs = {
        elephant.follows = "elephant";
        nixpkgs.follows = "nixpkgs";
      };
    };

    nur = {
      url = "github:nix-community/nur";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    dgop = {
      url = "github:AvengeMedia/dgop";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    dankMaterialShell = {
      url = "github:AvengeMedia/DankMaterialShell/stable";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.dgop.follows = "dgop";
    };

    noctalia = {
      url = "github:noctalia-dev/noctalia-shell";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    flake-parts,
    import-tree,
    ...
  } @ inputs:
    flake-parts.lib.mkFlake {inherit inputs;} (import-tree [
      ./hosts
      ./modules
      ./parts
    ]);
}
