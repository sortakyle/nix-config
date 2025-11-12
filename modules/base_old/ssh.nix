{
  flake.modules.nixos.base = {lib, ...}: let
    # Keys are used here by sops-nix before impermanence can make
    # links. Must just use `/persist` keys directly if impermanence.
    hasPersistDir = true;
  in {
    services.openssh = {
      enable = true;
      openFirewall = true;
      settings = {
        PermitRootLogin = "no";
        PasswordAuthentication = false;
        # agent forwarding management
        # remove stale sockets
        StreamLocalBindUnlink = "yes";
        # Allow forwarding ports to everywhere
        GatewayPorts = "clientspecified";
        X11Forwarding = true;
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

  flake.modules.homeManager.base = {outputs, ...}: let
    hostnames = builtins.attrNames outputs.nixosConfigurations;
  in {
    programs.ssh = {
      enable = true;
      enableDefaultConfig = false;
      matchBlocks = {
        net = {
          host = builtins.concatStringsSep " " hostnames;
          forwardAgent = true;
        };
        "*" = {
          addKeysToAgent = "no";
        };
      };
    };
  };
}
