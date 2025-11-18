{inputs, ...}: {
  hosts.nixos.mars = {
    zfs = {
      enableRollback = true;
      devices = ["/dev/sda2"]; # VM so disk has no id
    };
  };

  hosts.nixos.mars.module = {
    imports = [inputs.disko.nixosModules.disko];

    disko.devices = {
      disk.disk1 = {
        device = "/dev/sda"; # VM so disk has no id
        type = "disk";
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
          rootFsOptions = {
            acltype = "posixacl";
            xattr = "sa";
            canmount = "off";
            compression = "lz4";
            dnodesize = "auto";
            relatime = "on";
            dedup = "off";
            mountpoint = "none";
          };
          options = {
            ashift = "12";
          };
          datasets = {
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

    # Unsure if these are actually needed
    fileSystems."/nix".neededForBoot = true;
    fileSystems."/var/log".neededForBoot = true;
    fileSystems."/var/lib/nixos".neededForBoot = true;
    fileSystems."/var/lib/systemd".neededForBoot = true;
    fileSystems."/persist".neededForBoot = true;

    # Enable snaoid automated snapshots on the persist dataset
    services.sanoid.datasets."rpool/crypt/safe/persist".useTemplate = ["backup"];
  };
}
