{inputs, ...}: {
  hosts.nixos.caprica = {
    zfs = {
      enableRollback = true;
      devices = []; # TODO: populate with by-id references
    };
  };

  hosts.nixos.caprica.module = {lib, ...}: {
    imports = [inputs.disko.nixosModules.disko];

    disko.devices = {
      disk.boot = {
        type = "disk";
        device = "/dev/disk/by-id/"; # TODO
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
        device = "/dev/disk/by-id/"; # TODO
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
        device = "/dev/disk/by-id/"; # TODO
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

          datasets = {
            # LUKS encrypted zvol for storing boot credentials (unlocks crypt after being mounted)
            credstore = {
              type = "zfs_volume";
              size = "128M";
              content = {
                type = "luks";
                name = "credstore";
                content = {
                  type = "filesystem";
                  format = "ext4";
                };
              };
            };

            # reserving ~10% of the pool to ensure we dont hit zfs performance issues
            reservation = {
              type = "zfs_fs";
              options = {
                canmount = "off";
                mountpoint = "none";
                reservation = "400G";
              };
            };

            crypt = {
              type = "zfs_fs";
              options = {
                canmount = "off";
                mountpoint = "none";
                encryption = "aes-256-gcm";
                keyformat = "hex";
                keylocation = "file:///credstore/rpoolcrypt.key";
              };
              preCreateHook = "mount -o X-mount.mkdir /dev/mapper/credstore /credstore && od -Anone -x -N 32 -w64 /dev/random | tr -d \"[:blank:]\" > /credstore/rpoolcrypt.key";
              postCreateHook = "umount /credstore && cryptsetup luksClose /dev/mapper/credstore";
            };

            # local is important OS datasets which will use legacy mounts
            "crypt/local" = {
              type = "zfs_fs";
              options = {
                canmount = "off";
                mountpoint = "none";
              };
            };
            "crypt/local/root" = {
              type = "zfs_fs";
              options.mountpoint = "legacy";
              mountpoint = "/";
              postCreateHook = "zfs snapshot rpool/crypt/local/root@blank";
            };
            "crypt/local/nix" = {
              type = "zfs_fs";
              options.mountpoint = "legacy";
              mountpoint = "/nix";
            };
            "crypt/local/log" = {
              type = "zfs_fs";
              options.mountpoint = "legacy";
              mountpoint = "/var/log";
            };
            "crypt/local/nixoslib" = {
              type = "zfs_fs";
              options.mountpoint = "legacy";
              mountpoint = "/var/lib/nixos";
            };
            "crypt/local/systemd" = {
              type = "zfs_fs";
              options.mountpoint = "legacy";
              mountpoint = "/var/lib/systemd";
            };

            # safe is where anything persistent will be stored and then symlink'd
            # should be able to create sub datasets of anything in persist which we dont want
            # to be snapshot or backed up
            "crypt/safe" = {
              type = "zfs_fs";
              options = {
                canmount = "off";
                mountpoint = "none";
              };
            };
            "crypt/safe/persist" = {
              type = "zfs_fs";
              options.mountpoint = "/persist";
              mountpoint = "/persist";
            };
          };
        };
      };
    };

    # Mark these datasets as needed for boot. Unsure if actually needed
    fileSystems = let
      bootDatasets = [
        "/nix"
        "/var/log"
        "/var/lib/nixos"
        "/var/lib/systemd"
        "/persist"
      ];
    in
      lib.genAttrs bootDatasets (_fs: {neededForBoot = true;});

    # Enable snaoid automated snapshots on the persist dataset
    services.sanoid.datasets."rpool/crypt/safe/persist".useTemplate = ["backup"];
  };
}
