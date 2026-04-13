{
  inputs,
  pkgs,
  ...
}:

{
  imports = [
    ./disko.nix
    ./hardware-configuration.nix
    inputs.nixos-hardware.nixosModules.microsoft-surface-go
  ];

  hardware.microsoft-surface.kernelVersion = "stable";

  services.iptsd.enable = true;

  # Enabled for USB-C PD charging
  hardware.enableRedistributableFirmware = true;

  # TODO: Make surface-control work / make the various surface hardware accessable
  # Currently all uses of surface control just error
  environment.systemPackages = with pkgs; [
    surface-control
  ];

  fileSystems."/home/jonathan/music" = {
    device = "/dev/disk/by-label/MEDIA_SD";
    fsType = "btrfs";
    options = [
      "subvol=@music"
      "compress=zstd"
      "noatime"
      "noauto"
      "x-systemd.automount"
      "user"
    ];
  };

  fileSystems."/home/jonathan/videos" = {
    device = "/dev/disk/by-label/MEDIA_SD";
    fsType = "btrfs";
    options = [
      "subvol=@videos"
      "compress=zstd"
      "noatime"
      "noauto"
      "x-systemd.automount"
      "user"
    ];
  };
}
