{ config, ... }:

{
  imports = [
    ./disko.nix
    ./persistence.nix
    ./users.nix
    ./samba.nix
    ./plex.nix
    ./headless-laptop.nix
    ./nut.nix
    ./hardware-configuration.nix
    ../../modules/system/systemd-boot.nix
    ../../modules/system/common.nix
    ../../modules/system/networkmanager.nix
    ../../modules/system/sshd.nix
    ../../modules/system/docker.nix
    ../../modules/system/tailscale.nix
  ];

  networking.hostName = "jungle";

  # Keep HDD unlock resilient while keyfile automation is being bootstrapped.
  boot.initrd.luks.devices = {
    jungle-hdd1.fallbackToPassword = true;
    jungle-hdd2.fallbackToPassword = true;
  };

  # Allows LUKS password to be entered over ssh
  boot.initrd.network = {
    enable = true;
    ssh = {
      enable = true;
      port = 2222;
      authorizedKeys = config.users.users.jonathan.openssh.authorizedKeys.keys;
      hostKeys = [ "/persist/etc/ssh/ssh_host_ed25519_key" ];
    };
  };

  systemd.tmpfiles.rules = [
    "d /persist/etc/luks-keys 0700 root root - -"
  ];

  sops.age.sshKeyPaths = [ "/persist/etc/ssh/ssh_host_ed25519_key" ];

  # This option defines the first version of NixOS installed on this machine.
  system.stateVersion = "25.11";
}
