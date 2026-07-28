{ pkgs, ... }:

{
  users.groups.nixbuilder = { };

  users.users.nixbuilder = {
    description = "Remote Nix builder";
    isSystemUser = true;
    group = "nixbuilder";
    shell = pkgs.bash;
    openssh.authorizedKeys.keys = [
      "restrict ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAICqgFoYAWWIwgSBkOfY9oK/+KCGFTFM3ySFOztt5fcB1 meadow-to-forest-nixbuilder"
    ];
  };

  nix.settings.trusted-users = [ "nixbuilder" ];
}
