{ ... }:

{
  services.playerctld.enable = true;

  # Enable bluetooth input controls if bluetooth is enabled
  # Turns out Sennheiser ACCENTUM Plus send control signals all on their own
  # Proxy not needed
  services.mpris-proxy.enable = false;
}
