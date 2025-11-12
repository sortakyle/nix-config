{
  flake.modules.nixos.base = {
    networking.networkmanager.enable = true;
    services.resolved = {
      enable = true;

      # https://github.com/NixOS/nixpkgs/issues/180175
      # TODO: Unsure if actually necessary. Commenting out for now
      # systemd = {
      #   services.NetworkManager-wait-online.enable = false;
      #   network.wait-online.enable = false;
      # };

      # disables fallback. Always want to go through router DNS for homelab resolution
      fallbackDns = [];
    };
  };
}
