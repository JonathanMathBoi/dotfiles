{ pkgs, ... }:

{
  imports = [
    ./disko.nix
    ./hardware-configuration.nix
    ../../modules/system/systemd-boot.nix
    ../../modules/system/common.nix
    ../../modules/system/networkmanager.nix
    ../../modules/system/sshd.nix
    ../../modules/system/udisks.nix
    ../../modules/system/pipewire.nix
    ../../modules/system/bluetooth.nix
    ../../modules/system/hyprland.nix
    ../../modules/system/greetd.nix
    ../../modules/system/tailscale.nix
  ];

  hardware.microsoft-surface.kernelVersion = "stable";

  networking.hostName = "meadow";

  users.users.jonathan.hashedPasswordFile = "/etc/secrets/jonathan-password";

  services.iptsd.enable = true;

  # Enabled for USB-C PD charging
  hardware.enableRedistributableFirmware = true;

  # Power management
  services.power-profiles-daemon.enable = true;
  # Disabled since power-profiles-daemon is the new standard way to deal with that
  services.tlp.enable = false;

  # TODO: Make this actually work.
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

      # Systemd automount options
      "noauto"
      "x-systemd.automount"
      "x-systemd.idle-timeout=60"

      # Allows to mount and umount without sudo
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

      # Systemd automount options
      "noauto"
      "x-systemd.automount"
      "x-systemd.idle-timeout=60"

      # Allows to mount and umount without sudo
      "user"
    ];
  };

  # This option defines the first version of NixOS you have installed on this particular machine,
  # and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
  #
  # Most users should NEVER change this value after the initial install, for any reason,
  # even if you've upgraded your system to a new NixOS release.
  #
  # This value does NOT affect the Nixpkgs version your packages and OS are pulled from,
  # so changing it will NOT upgrade your system - see https://nixos.org/manual/nixos/stable/#sec-upgrading for how
  # to actually do that.
  #
  # This value being lower than the current NixOS release does NOT mean your system is
  # out of date, out of support, or vulnerable.
  #
  # Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
  # and migrated your data accordingly.
  #
  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "25.11"; # Did you read the comment?
}
