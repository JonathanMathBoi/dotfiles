{ inputs, ... }:

{
  imports = [
    inputs.disko.nixosModules.disko
  ];

  disko.devices = {
    disk = {
      ssd = {
        type = "disk";
        device = "/dev/disk/by-id/ata-LITEONIT_LCS-256L9S-11_2.5_7mm_256GB_TW03YYV35508557K1591";
        content = {
          type = "gpt";
          partitions = {
            ESP = {
              size = "2G";
              type = "EF00";
              content = {
                type = "filesystem";
                format = "vfat";
                mountpoint = "/boot";
                mountOptions = [ "umask=0077" ];
              };
            };
            luks = {
              size = "100%";
              content = {
                type = "luks";
                name = "jungle-ssd-crypted";
                settings.allowDiscards = true;
                content = {
                  type = "btrfs";
                  extraArgs = [ "-f" ];
                  subvolumes = {
                    "@persist" = {
                      mountpoint = "/persist";
                      mountOptions = [
                        "compress=zstd"
                        "noatime"
                      ];
                    };
                    "@nix" = {
                      mountpoint = "/nix";
                      mountOptions = [
                        "compress=zstd"
                        "noatime"
                      ];
                    };
                    "@swap" = {
                      mountpoint = "/swap";
                      mountOptions = [
                        "nodatacow"
                        "noatime"
                      ];
                      swap.swapfile.size = "8G";
                    };
                    "@docker" = {
                      mountpoint = "/var/lib/docker";
                      mountOptions = [
                        "nodatacow"
                        "noatime"
                      ];
                    };
                  };
                };
              };
            };
          };
        };
      };

      # Keep this first so the second HDD can reference /dev/mapper/jungle-hdd1.
      hdd1 = {
        type = "disk";
        device = "/dev/disk/by-id/wwn-0x5000c500ebe21402";
        content = {
          type = "gpt";
          partitions = {
            luks = {
              size = "100%";
              content = {
                type = "luks";
                name = "jungle-hdd1";
                settings = {
                  allowDiscards = true;
                  keyFile = "/persist/etc/luks-keys/jungle-hdd.key";
                };
              };
            };
          };
        };
      };

      hdd2 = {
        type = "disk";
        device = "/dev/disk/by-id/wwn-0x50014ee26c793ffd";
        content = {
          type = "gpt";
          partitions = {
            luks = {
              size = "100%";
              content = {
                type = "luks";
                name = "jungle-hdd2";
                settings = {
                  allowDiscards = true;
                  keyFile = "/persist/etc/luks-keys/jungle-hdd.key";
                };
                content = {
                  type = "btrfs";
                  extraArgs = [
                    "-f"
                    "-d raid1"
                    "-m raid1"
                    "/dev/mapper/jungle-hdd1"
                  ];
                  subvolumes = {
                    "@home" = {
                      mountpoint = "/home";
                      mountOptions = [
                        "compress=zstd"
                        "noatime"
                      ];
                    };
                    "@media" = {
                      mountpoint = "/srv/media";
                      mountOptions = [
                        "compress=zstd"
                        "noatime"
                      ];
                    };
                    "@shared" = {
                      mountpoint = "/srv/shared";
                      mountOptions = [
                        "compress=zstd"
                        "noatime"
                      ];
                    };
                    "@backups" = {
                      mountpoint = "/srv/backups";
                      mountOptions = [
                        "compress=zstd"
                        "noatime"
                      ];
                    };
                  };
                };
              };
            };
          };
        };
      };
    };

    nodev."/" = {
      fsType = "tmpfs";
      mountOptions = [
        "size=8G"
        "defaults"
        "mode=755"
      ];
    };
  };

  fileSystems."/persist".neededForBoot = true;
}
