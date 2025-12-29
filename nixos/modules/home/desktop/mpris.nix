{ osConfig, lib, ... }:

{
  services.playerctld.enable = true;

  # Enable bluetooth input controls if bluetooth is enabled
  services.mpris-proxy.enable = lib.mkIf osConfig.hardware.bluetooth.enable true;
}
