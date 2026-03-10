{
  inputs,
  config,
  pkgs,
  ...
}:

{
  imports = [
    inputs.sops-nix.nixosModules.sops
  ];

  sops = {
    defaultSopsFile = ../../secrets/secrets.yaml;
    defaultSopsFormat = "yaml";

    secrets = {
      # Dynamically assign the password secret based on the current hostname
      "${config.networking.hostName}/jonathan/password" = {
        neededForUsers = true;
      };
    };
  };

  environment.systemPackages = with pkgs; [
    sops
    age
  ];
}
