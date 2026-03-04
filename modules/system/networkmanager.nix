{ ... }:

{
  networking.networkmanager.enable = true;

  users.users.jonathan.extraGroups = [ "networkmanager" ];

  # TODO: Use the sops secrets and sops templates to generate wifi configs
}
