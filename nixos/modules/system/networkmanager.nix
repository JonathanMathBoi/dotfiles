{
  config,
  lib,
  pkgs,
  ...
}:

{
  networking.networkmanager.enable = true;

  users.users.jonathan.extraGroups = [ "networkmanager" ];
}
