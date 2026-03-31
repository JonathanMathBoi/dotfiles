{ lib, config, ... }:

let
  hasBtrfs = lib.any (fs: (fs.fsType or null) == "btrfs") (lib.attrValues config.fileSystems);
in
{
  services.btrfs.autoScrub = {
    enable = lib.mkDefault hasBtrfs;
    interval = "monthly";
    limit = "100M";
  };
}
