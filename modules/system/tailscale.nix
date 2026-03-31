{ config, ... }:

{
  sops.secrets."api/tailscale" = { };

  services.tailscale = {
    enable = true;
    authKeyFile = config.sops.secrets."api/tailscale".path;
  };

  networking.firewall = {
    trustedInterfaces = [ "tailscale0" ];

    # In case I use an exit node later
    checkReversePath = "loose";
  };
}
