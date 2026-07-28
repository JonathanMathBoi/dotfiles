{ config, lib, ... }:

let
  builderKey = config.sops.secrets."builder/forest/private-key".path;
in
{
  sops.secrets."builder/forest/private-key" = {
    mode = "0400";
  };

  nix = {
    distributedBuilds = true;
    buildMachines = [
      {
        hostName = "forest";
        system = "x86_64-linux";
        protocol = "ssh-ng";
        sshUser = "nixbuilder";
        sshKey = builderKey;
        maxJobs = 4;
      }
    ];

    # Prefer the remote builder instead of consuming Meadow's local resources.
    settings.max-jobs = lib.mkForce 0;
  };
}
