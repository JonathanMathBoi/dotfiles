{ pkgs, ... }:

{
  services.wivrn = {
    enable = true;
    openFirewall = true;
    autoStart = true;
    steam.enable = true;
  };

  environment.systemPackages = with pkgs; [
    wivrn
    xrizer
  ];

  # Ensure avahi is running for zero-config mDNS headset discovery
  services.avahi.enable = true;
}
