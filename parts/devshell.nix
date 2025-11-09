{
  perSystem = {pkgs, ...}: {
    devShells = {
      default = pkgs.mkShell {
        NIX_CONFIG = "extra-experimental-features = nix-command flakes pipe-operators recursive-nix";
        buildInputs = with pkgs; [
          nix
          nix-diff
          git
          nh

          nil
          alejandra
          nixd
          jq
        ];
      };
    };
  };
}
