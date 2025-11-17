{
  flake.modules.nixos.base = {
    pkgs,
    lib,
    hostConfig,
    ...
  }: {
    environment.systemPackages = with pkgs; [
      # `sudo ncdu -x /`
      ncdu
    ];

    # See https://nixos.org/manual/nixos/stable/#ch-system-state for the OS recommended persistence
    # - /boot special ESP partition
    # - /nix, /var/log, /var/lib/nixos, & /var/lib/systemd persistence expected to be managed by zfs
    preserve.system = {
      directories = [
        "/etc/NetworkManager/system-connections"

        # network
        "/var/lib/bluetooth"
        "/var/lib/NetworkManager"
        "/var/lib/iwd"
      ];
      files = [
        # auto-generated machine ID
        {
          file = "/etc/machine-id";
          inInitrd = true;
        }
        # used by system startup to discover ZFS pools
        {
          file = "/etc/zfs/zpool.cache";
          inInitrd = true;
        }
      ];
    };

    preserve.users = {
      directories = [
        # nix-config repo
        ".nix-config"

        # Nix / Home Manager Profiles
        ".local/share/nix"
        ".local/state/home-manager"
        ".local/state/nix/profiles"

        # vscode server
        ".vscode-server"
      ];
    };

    # Note: https://github.com/nix-community/preservation/issues/20
    # must be group users & mode 0755 for it to generate without conflicts
    systemd.tmpfiles.settings.preservation = let
      paths = user: let
        permission = {
          inherit user;
          group = "users";
          mode = "0755";
        };
      in {
        "/home/${user}/.config".d = permission;
        "/home/${user}/.local".d = permission;
        "/home/${user}/.local/share".d = permission;
        "/home/${user}/.local/state".d = permission;
      };
    in
      lib.mergeAttrsList (lib.attrsets.mapAttrsToList (name: _: (paths name)) hostConfig.users);

    # let the service commit the transient ID to the persistent volume
    systemd.suppressedSystemUnits = ["systemd-machine-id-commit.service"];
    systemd.services.systemd-machine-id-commit = {
      unitConfig.ConditionPathIsMountPoint = [
        ""
        "/persist/etc/machine-id"
      ];
      serviceConfig.ExecStart = [
        ""
        "systemd-machine-id-setup --commit --root /persist"
      ];
    };
  };
}
