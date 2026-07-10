{ pkgs, config, ... }:

let
  # Local User Info
  username = "jonathan";
  gid = toString config.users.groups.users.gid;

  # NAS Shares Info
  nasAddr = "jungle";
  shares = [
    "media"
    "shared"
    username
  ];

  # Mounting Info
  baseMountPath = "/mnt/nas";
  commonOptions = [
    # Automount options
    "x-systemd.automount"
    "noauto"
    "x-systemd.idle-timeout=60"

    # Ensure Tailscale is up
    "x-systemd.after=network-online.target"
    "x-systemd.requires=network-online.target"

    # Creds for Samba
    "credentials=${config.sops.secrets."jungle/jonathan/samba-creds".path}"

    # Permissions Mapping
    "uid=${username}"
    "gid=${gid}"
    "dir_mode=0755"
    "file_mode=0644"

    # Samba Performance
    "iocharset=utf8"
    "vers=3.0"
  ];
in
{
  sops.secrets."jungle/jonathan/samba-creds" = {
    # Mount occures as root
    owner = "root";
  };

  # Needed to help mount the samba shares
  environment.systemPackages = [ pkgs.cifs-utils ];

  fileSystems = builtins.listToAttrs (
    map (share: {
      name = "${baseMountPath}/${share}";
      value = {
        device = "//${nasAddr}/${share}";
        fsType = "cifs";
        options = commonOptions;
      };
    }) shares
  );
}
