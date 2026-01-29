# This module wraps https://github.com/nix-community/preservation to:
# 1. simplify syntax for defining preservation configuration
# 2. set a universal preserveAt directory which only needs to be declared once
# 3. provide access to preservation settings in home-manager (home.preserve.)
{inputs}: {
  imports = [
    inputs.preservation.nixosModules.default
    ./nixos.nix
  ];
}
