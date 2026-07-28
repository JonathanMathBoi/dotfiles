{ config, ... }:

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
        publicHostKey = "AAAAC3NzaC1lZDI1NTE5AAAAIDnedLKPkv/K/8j2VuLwUweWnp4dI19mI9413Q1hGWiS";
        maxJobs = 4;
      }
    ];
  };
}
