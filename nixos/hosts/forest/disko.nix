{
  disko.devices = {
    disk = {
      main = {
        type = "disk";
        device = "/dev/disk/by-id/nvme-Sabrent_SB-ROCKET-NVMe4-1TB_48790459514184";
        content = {
          type = "gpt";
          partitions = {
            ESP = {
              size = "1G";
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
                name = "crypted";
                settings.allowDiscards = true;
                content = {
                  type = "btrfs";
                  extraArgs = [ "-f" ]; # Override existing partition
                  subvolumes = {
                    "@persist" = {
                      mountOptions = [
                        "compress=zstd"
                        "noatime"
                      ];
                    };
                    "@home" = {
                      mountOptions = [
                        "compress=zstd"
                        "noatime"
                      ];
                      mountpoint = "/home";
                    };
                    "@nix" = {
                      mountOptions = [
                        "compress=zstd"
                        "noatime"
                      ];
                      mountpoint = "/nix";
                    };
                    "@swap" = {
                      mountOptions = [
                        "noatime"
                        "nodatacow"
                      ];
                      mountpoint = "/swap";
                      swap.swapfile.size = "8G";
                    };
                    "@docker" = {
                      mountOptions = [
                        "nodatacow"
                        "noatime"
                      ];
                      mountpoint = "/var/lib/docker";
                    };
                    "@vms" = {
                      mountOptions = [
                        "nodatacow"
                        "noatime"
                      ];
                      mountpoint = "/var/lib/libvirt";
                    };
                    "@steam" = {
                      mountOptions = [
                        "compress=zstd"
                        "noatime"
                      ];
                      mountpoint = "/home/jonathan/.local/share/Steam";
                    };
                    "@ollama" = {
                      mountOptions = [
                        "compress=zstd"
                        "noatime"
                      ];
                      mountpoint = "/var/lib/ollama";
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

  # Needed for impermanence to work right
  fileSystems."/persist".neededForBoot = true;
}
