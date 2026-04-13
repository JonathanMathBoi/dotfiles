{ pkgs, ... }:

{
  users.groups.family = { };

  users.users.jonathan.extraGroups = [ "family" ];

  users.users.michael = {
    isNormalUser = true;
    extraGroups = [ "family" ];
    shell = "${pkgs.shadow}/bin/nologin";
    hashedPassword = "!";
  };

  users.users.christopher = {
    isNormalUser = true;
    extraGroups = [ "family" ];
    shell = "${pkgs.shadow}/bin/nologin";
    hashedPassword = "!";
  };

  users.users.lynn = {
    isNormalUser = true;
    extraGroups = [ "family" ];
    shell = "${pkgs.shadow}/bin/nologin";
    hashedPassword = "!";
  };

  systemd.tmpfiles.rules = [
    "d /home/michael/documents 0750 michael michael - -"
    "d /home/michael/pictures 0750 michael michael - -"
    "d /home/michael/videos 0750 michael michael - -"
    "d /home/christopher/documents 0750 christopher christopher - -"
    "d /home/christopher/pictures 0750 christopher christopher - -"
    "d /home/christopher/videos 0750 christopher christopher - -"
    "d /home/lynn/documents 0750 lynn lynn - -"
    "d /home/lynn/pictures 0750 lynn lynn - -"
    "d /home/lynn/videos 0750 lynn lynn - -"
  ];
}
