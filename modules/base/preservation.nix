{
  flake.modules.nixos.base = {
    inputs,
    pkgs,
    lib,
    hostConfig,
    ...
  }: {
    imports = [inputs.preservation.nixosModules.default];

    environment.systemPackages = with pkgs; [
      # `sudo ncdu -x /`
      ncdu
    ];

    # See https://nixos.org/manual/nixos/stable/#ch-system-state for the OS recommended persistence
    preservation.preserveAt."/persist" = {
      directories = [
        "/etc/NetworkManager/system-connections"

        # containers
        "/var/lib/containers"
        "/var/lib/cni"

        # virtualization
        "/var/lib/libvirt"
        "/var/lib/qemu"

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

      users =
        lib.mapAttrs (_: _: {
          commonMountOptions = [
            "x-gvfs-hide"
          ];
          directories = [
            # XDG Directories
            "Music"
            "Pictures"
            "Documents"
            "Videos"
            #"Downloads"

            # nix-config repo
            ".nix-config"

            # Nix / Home Manager Profiles
            ".local/share/nix"
            ".local/state/home-manager"
            ".local/state/nix/profiles"

            # vscode server
            ".vscode-server"
          ];
        })
        hostConfig.users;
    };

    # must be group users & mode 0755 for it to work correctly
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

    systemd.suppressedSystemUnits = ["systemd-machine-id-commit.service"];

    # let the service commit the transient ID to the persistent volume
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
