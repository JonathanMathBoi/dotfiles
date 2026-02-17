# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{
  config,
  lib,
  pkgs,
  ...
}:

{
  imports = [
    ./hardware-configuration.nix
    ../../modules/system/systemd-boot.nix
    ../../modules/system/common.nix
    ../../modules/system/networkmanager.nix
    ../../modules/system/sshd.nix
    ../../modules/system/udisks.nix
    ../../modules/system/docker.nix
    ../../modules/system/pipewire.nix
    ../../modules/system/bluetooth.nix
    ../../modules/system/hyprland.nix
    ../../modules/system/greetd.nix
    ../../modules/system/steam.nix
    ../../modules/system/tailscale.nix
  ];

  # Use latest kernel.
  boot.kernelPackages = pkgs.linuxPackages_latest;

  networking.hostName = "forest";

  boot.kernelParams = [
    # Disable i915 drivers and enable xe drivers
    "i915.force_probe=!56a1"
    "xe.force_probe=56a1"
  ];

  hardware.graphics = {
    enable = true;
    extraPackages = with pkgs; [
      vpl-gpu-rt
      intel-media-driver
      intel-compute-runtime
    ];
  };

  environment.systemPackages = with pkgs; [
    intel-gpu-tools
    clinfo
  ];

  services.ollama = {
    enable = true;
    package = pkgs.ollama-vulkan;
    user = "ollama";
    group = "ollama";
  };

  environment.variables = {
    ONEAPI_DEVICE_SELECTOR = "level_zero:0";
  };

  # The ollama NixOS module defaults DynamicUser to true, which conflicts with
  # /var/lib/ollama being a separate subvolume mount point.
  # mkForce is used here to override the default and allow the service to manage
  # its data on the pre-existing subvolume.
  systemd.services.ollama.serviceConfig.DynamicUser = lib.mkForce false;

  systemd.tmpfiles.rules = [
    "d /var/lib/ollama 0750 ollama ollama - -"
    "d /var/lib/ollama/models 0750 ollama ollama - -"
    "d /home/jonathan/.local/share/Steam 0755 jonathan users - -"
  ];

  boot.loader.systemd-boot = {
    windows = {
      "11" = {
        title = "Windows 11";
        efiDeviceHandle = "FS1";
      };
    };
  };

  environment.persistence."/persist" = {
    enable = true;
    hideMounts = true;
    directories = [
      "/var/log"
      "/var/lib/bluetooth"
      "/var/lib/nixos"
      "/var/lib/docker"
      "/var/lib/tailscale"
      "/var/lib/systemd/coredump"
      "/var/lib/systemd/timers"
      "/etc/NetworkManager/system-connections"
      "/etc/ssh"
    ];
    files = [
      "/etc/machine-id"
      "/etc/shadow"
      "/etc/passwd"
      "/etc/group"
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
