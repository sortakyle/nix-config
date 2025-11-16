{
  flake.modules.nixos.base = {outputs, ...}: {
    nixpkgs = {
      # global overlays
      overlays = builtins.attrValues outputs.overlays;
    };

    nix = {
      # Uncomment if I want to try lix: https://lix.systems/
      #package = pkgs.lixPackageSets.latest.lix;

      # From https://jackson.dev/post/nix-reasonable-defaults/
      extraOptions = ''
        connect-timeout = 5
        log-lines = 50
        min-free = 128000000
        max-free = 1000000000
        fallback = true
      '';
      optimise.automatic = true;
      settings = {
        auto-optimise-store = true;
        trusted-users = [
          "root"
          "@wheel"
        ];
        experimental-features = [
          "nix-command"
          "flakes"
        ];
        warn-dirty = false;
        tarball-ttl = 60 * 60 * 24;
        builders-use-substitutes = true;
        use-xdg-base-directories = true;
      };
    };

    # Instead of using nix.gc, we are using nh clean
    programs.nh = {
      enable = true;
      clean.enable = true;
      clean.extraArgs = "--keep-since 8d --keep 3";
    };
  };

  flake.modules.homeManager.base = {lib, ...}: {
    home.sessionVariables.NH_FLAKE = lib.mkDefault "";
  };
}
