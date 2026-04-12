{ lib, ... }:

{
  services.plex = {
    enable = true;
    openFirewall = true;
    dataDir = "/persist/plex";
  };

  users.users.plex.extraGroups = [ "family" ];

  systemd.services.plex.environment.PLEX_MEDIA_SERVER_TMPDIR = lib.mkForce "/persist/plex/transcode";

  systemd.tmpfiles.rules = [
    "d /persist/plex 0750 plex plex - -"
    "d /persist/plex/transcode 0750 plex plex - -"
  ];
}
