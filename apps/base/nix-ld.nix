{
  flake.modules.nixos.base = {
    # This enables unpatched dynamic binaries to run on NixOS.
    # We need this for VS Code Server w/ any extension which may include non-nix binaries
    # TODO: alternative is to use nix-vscode-server which is a bit more restrictive
    programs.nix-ld.enable = true;
  };
}
