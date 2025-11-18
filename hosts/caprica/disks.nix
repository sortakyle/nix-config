{inputs, ...}: let
  bootDisk = "/dev/disk/by-id/"; # TODO
  zfsDisk1 = "/dev/disk/by-id/"; # TODO
  zfsDisk2 = "/dev/disk/by-id/"; # TODO
in {
  hosts.nixos.caprica = {
    zfs = {
      enableRollback = true;
      devices = [zfsDisk1 zfsDisk2]; # TODO: populate with by-id references
    };
  };

  hosts.nixos.caprica.module = {
    imports = [inputs.disko.nixosModules.disko];

    disko.devices = {
      disk.bootDisk = {
        type = "disk";
        device = bootDisk; # TODO
        content = {
          type = "gpt";
          partitions = {
            ESP = {
              name = "boot";
              size = "1G";
              type = "EF00";
              content = {
                type = "filesystem";
                format = "vfat";
                mountpoint = "/boot";
                mountOptions = ["umask=0077"];
              };
            };
            swap = {
              name = "optane-swap";
              size = "12G";
              content = {
                type = "swap";
                randomEncryption = true;
                mountOptions = ["discard"];
              };
            };
          };
        };
      };

      disk.disk1 = {
        type = "disk";
        device = zfsDisk1; # TODO
        content = {
          type = "gpt";
          partitions = {
            zfs = {
              size = "100%";
              content = {
                type = "zfs";
                pool = "rpool";
              };
            };
          };
        };
      };

      disk.disk2 = {
        type = "disk";
        device = zfsDisk2; # TODO
        content = {
          type = "gpt";
          partitions = {
            zfs = {
              size = "100%";
              content = {
                type = "zfs";
                pool = "rpool";
              };
            };
          };
        };
      };

      zpool = {
        rpool = {
          type = "zpool";
          mode = {
            topology = {
              type = "topology";
              vdev = [
                {
                  mode = "mirror";
                  members = ["disk1" "disk2"];
                }
              ];
            };
          };

          # ZFS Settings
          rootFsOptions = {
            acltype = "posixacl";
            xattr = "sa";
            compression = "lz4";
            dnodesize = "auto";
            relatime = "on";
            dedup = "off";
            mountpoint = "none";
            canmount = "off";
          };
          options = {
            ashift = "12";
          };
        };
      };
    };
  };
}
