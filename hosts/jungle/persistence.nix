{ ... }:

{
  environment.persistence."/persist" = {
    enable = true;
    hideMounts = true;

    directories = [
      "/etc/luks-keys"
      "/var/log"
      "/var/db/sudo"
      "/var/lib/nixos"
      "/var/lib/tailscale"
      "/var/lib/samba"
      "/var/lib/nut"
      "/var/log/samba"
      "/var/lib/systemd/coredump"
      "/var/lib/systemd/timers"
      "/etc/NetworkManager/system-connections"
    ];

    files = [
      "/etc/machine-id"
      "/etc/ssh/ssh_host_ed25519_key"
      "/etc/ssh/ssh_host_ed25519_key.pub"
      "/etc/ssh/ssh_host_rsa_key"
      "/etc/ssh/ssh_host_rsa_key.pub"
    ];
  };
}
