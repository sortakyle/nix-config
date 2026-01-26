{
  flake.modules.nixos.zfs = {
    host,
    lib,
    config,
    ...
  }: let
    rollbackSnapshot = "rpool/crypt/local/root@blank";
  in {
    boot.initrd.systemd = lib.mkIf host.zfs.enableRollback {
      services.zfs-rollback = {
        description = "Rollback ZFS root dataset to blank snapshot";
        wantedBy = ["initrd.target"];
        after = ["zfs-import-rpool.service"];
        before = ["sysroot.mount"];
        path = [config.boot.zfs.package];
        unitConfig.DefaultDependencies = "no";
        serviceConfig.Type = "oneshot";
        script = ''
          zfs rollback -r ${rollbackSnapshot} && echo "zfs rollback complete";
        '';
      };
    };
  };
}
