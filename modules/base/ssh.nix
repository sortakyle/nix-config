{
  flake.modules.nixos.base = {
    lib,
    hostConfig,
    ...
  }: let

    # Keys are used here by sops-nix before impermanence can make
    # links. Must just use `/persist` keys directly if impermanence.
    hasPersistDir = hostConfig.preservation.enable;
  in {
    services.openssh = {
      enable = true;
      settings = {
        PermitRootLogin = "no";
        PasswordAuthentication = false;
        # agent forwarding management
        # remove stale sockets
        StreamLocalBindUnlink = "yes";
        # Allow forwarding ports to everywhere
        GatewayPorts = "clientspecified";
      };
      
      hostKeys = [
      {
        path = "${lib.optionalString hasPersistDir "/persist"}/etc/ssh/ssh_host_ed25519_key";
        type = "ed25519";
      }
    ];
    };

    environment.enableAllTerminfo = true;
  };
}