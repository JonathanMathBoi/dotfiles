{ pkgs, ... }:

{
  users.groups.family = { };

  users.users.jonathan.extraGroups = [ "family" ];

  users.users.michael = {
    isNormalUser = true;
    group = "family";
    shell = "${pkgs.shadow}/bin/nologin";
    hashedPassword = "!";
  };

  users.users.christopher = {
    isNormalUser = true;
    group = "family";
    shell = "${pkgs.shadow}/bin/nologin";
    hashedPassword = "!";
  };

  users.users.lynn = {
    isNormalUser = true;
    group = "family";
    shell = "${pkgs.shadow}/bin/nologin";
    hashedPassword = "!";
  };
}
