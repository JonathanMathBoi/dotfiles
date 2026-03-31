{ lib, ... }:

{
  imports = [
    ./disko.nix
    ./persistence.nix
    # TODO: Add hardware-configuration.nix
    # ./hardware-configuration.nix
    ../../modules/system/systemd-boot.nix
    ../../modules/system/common.nix
    ../../modules/system/networkmanager.nix
    ../../modules/system/sshd.nix
    ../../modules/system/docker.nix
    ../../modules/system/tailscale.nix
  ];

  networking.hostName = "jungle";

  # HACK: To allow nix eval to run before the hardware-configuration is made
  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";

  # Keep HDD unlock resilient while keyfile automation is being bootstrapped.
  boot.initrd.luks.devices = {
    jungle-hdd1.fallbackToPassword = true;
    jungle-hdd2.fallbackToPassword = true;
  };

  systemd.tmpfiles.rules = [
    "d /persist/etc/luks-keys 0700 root root - -"
  ];

  sops.age.sshKeyPaths = [ "/persist/etc/ssh/ssh_host_ed25519_key" ];

  # This option defines the first version of NixOS installed on this machine.
  system.stateVersion = "25.11";
}
