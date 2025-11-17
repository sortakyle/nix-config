{
  flake.modules.nixos.base = {
    lib,
    config,
    outputs,
    ...
  }: let
    inherit (config.networking) hostName;
    excludeHosts = ["iso"];
    hosts = lib.attrsets.filterAttrs (n: _v: !builtins.elem n excludeHosts) outputs.nixosConfigurations;
    pubKey = host: ../../hosts/${host}/ssh_host_ed25519_key.pub;

    hasPersistDir = config.preserve.enable;
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

    programs.ssh = {
      knownHosts =
        builtins.mapAttrs (name: _: {
          publicKeyFile = pubKey name;
          # Alias for localhost if it's the same host
          extraHostNames = lib.optional (name == hostName) "localhost";
        })
        hosts;
    };

    preserve.users.directories = [".ssh"];
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
