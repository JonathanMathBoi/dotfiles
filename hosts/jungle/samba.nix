{ ... }:

{
  services.samba = {
    enable = true;
    openFirewall = true;

    settings = {
      global = {
        workgroup = "WORKGROUP";
        "server string" = "jungle";
        "netbios name" = "jungle";
        security = "user";
        "map to guest" = "never";
        "server min protocol" = "SMB2";
        "invalid users" = [ "root" ];
      };

      homes = {
        browseable = "no";
        "read only" = "no";
        "valid users" = "%S";
      };

      media = {
        path = "/srv/media";
        browseable = "yes";
        "read only" = "yes";
        "valid users" = [ "@family" ];
        "write list" = [ "jonathan" ];
      };

      shared = {
        path = "/srv/shared";
        browseable = "yes";
        "read only" = "no";
        "valid users" = [ "@family" ];
        "force group" = "family";
        "create mask" = "0664";
        "directory mask" = "2775";
      };
    };
  };

  # Better discovery in Windows Explorer.
  services.samba-wsdd = {
    enable = true;
    openFirewall = true;
    hostname = "jungle";
  };

  systemd.tmpfiles.rules = [
    "d /srv/shared 2775 jonathan family - -"
    "d /srv/media 2755 jonathan family - -"
  ];
}
