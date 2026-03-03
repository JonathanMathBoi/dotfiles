{ inputs, config, ... }:

{
  imports = [
    inputs.sops-nix.nixosModules.sops
  ];

  sops = {
    defaultSopsFile = ../../secrets/secrets.yaml;
    defaultSopsFormat = "yaml";

    age = {
      sshKeyPaths = [ "/etc/ssh/ssh_host_ed25519_key" ];
    };

    secrets = {
      # Dynamically assign the password secret based on the current hostname
      "${config.networking.hostName}/jonathan/password" = {
        neededForUsers = true;
      };
    };
  };
}
