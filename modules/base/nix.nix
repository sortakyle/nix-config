{
  config = let
    settings = {
      keep-outputs = true;
      experimental-features = [
        "nix-command"
        "flakes"
        "pipe-operators"
        "recursive-nix"
      ];
      extra-system-features = ["recursive-nix"];
      trusted-users = [
        "root"
        "@wheel"
      ];
      auto-optimise-store = true;
      warn-dirty = false;
    };
  in {
    flake.modules.nixos.base = {
      inputs,
      outputs,
      lib,
      hostConfig,
      ...
    }: {
      nixpkgs = {
        overlays = builtins.attrValues outputs.overlays;
        config = {
          allowUnfree = true;
        };
      };

      nix = {
        inherit settings;

        # Add each flake input to nix registry
        registry = lib.mapAttrs (_: value: {flake = value;}) inputs;
      };

      preservation.preserveAt."/persist" = {
        directories = ["/root/.local/share/nix"];
        users =
          lib.mapAttrs (_: _: {
            directories = [
              ".nix-config"
              ".local/share/nix"
            ];
          })
          hostConfig.users;
      };
    };

    flake.modules.homeManager.base = {
      lib,
      pkgs,
      ...
    }: {
      home.sessionVariables.FLAKE = lib.mkDefault "~/.nix-config";

      nix = {
        inherit settings;
        package = lib.mkDefault pkgs.nix;
      };
    };
  };
}
