{
  flake.modules.nixos.zfs = {
    config,
    lib,
    hostConfig,
    utils,
    ...
  }: {
    boot.initrd = {
      # /credstore is an ext4 filesystem that needs to be mounted
      supportedFilesystems.ext4 = true;

      # Creates systemd-cryptsetup@credstore
      luks.devices.credstore.device = "/dev/zvol/rpool/credstore";

      # Must have systemd initrd to get this configuration to work
      systemd.enable = lib.mkForce true;

      # Manually mount the LUKS credstore before rpool import to have the encryption secret available
      systemd.mounts = [
        {
          description = "Secrets storage for stage 1 boot";
          where = "/credstore";
          what = "/dev/mapper/credstore";
          options = "nofail,noauto,noexec,ro";
          bindsTo = [
            "systemd-cryptsetup@credstore.service"
          ];
          after = [
            "systemd-cryptsetup@credstore.service"
          ];
          wantedBy = ["zfs-import-rpool.service"];
          before = ["zfs-import-rpool.service"];
        }
      ];

      systemd.services = {
        zfs-import-rpool-raw = let
          devices = map (p: utils.escapeSystemdPath p + ".device") hostConfig.zfs.devices;
        in {
          # Devices are added to 'wants' instead of 'requires' so that a degraded import may be
          # attempted if one of them times out. We want this to finish before
          # 'systemd-cryptsetup@.service' instances begin running.
          requires = ["modprobe@zfs.service"];
          after = ["modprobe@zfs.service"] ++ devices;
          wants = ["cryptsetup.target"] ++ devices;
          before = [
            "cryptsetup.target"
            "shutdown.target"
          ];
          wantedBy = ["cryptsetup.target"];
          conflicts = ["shutdown.target"];

          unitConfig.DefaultDependencies = "no";
          serviceConfig = {
            Type = "oneshot";
            RemainAfterExit = true;
          };
          enableStrictShellChecks = true;
          path = [config.boot.zfs.package];
          script = ''
            zpool import -d ${config.boot.zfs.devNodes} rpool
          '';
        };

        # We only need the credstore for boots, so lock it back up after we are done importing zfs
        mask-credstore = {
          description = "Clean up credstore";
          after = ["zfs-import-rpool.service"];
          wantedBy = ["initrd-switch-root.target"];
          before = ["initrd-switch-root.target"];
          unitConfig.DefaultDependencies = "no";
          serviceConfig.Type = "oneshot";
          script = ''
            systemctl disable --now credstore.mount
            systemctl mask credstore.mount
          '';
        };
        mask-cryptsetup-credstore = {
          description = "Clean up cryptsetup of credstore";
          after = [
            "zfs-import-rpool.service"
            "mask-credstore.service"
          ];
          wantedBy = ["initrd-switch-root.target"];
          before = ["initrd-switch-root.target"];
          unitConfig.DefaultDependencies = "no";
          serviceConfig.Type = "oneshot";
          script = ''
            systemd-cryptsetup detach credstore
            systemctl mask systemd-cryptsetup@credstore.service
          '';
        };
      };
    };
  };
}
