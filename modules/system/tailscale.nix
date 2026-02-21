{ ... }:

{
  services.tailscale.enable = true;

  networking.firewall = {
    trustedInterfaces = [ "tailscale0" ];

    # In case I use an exit node later
    checkReversePath = "loose";
  };
}
