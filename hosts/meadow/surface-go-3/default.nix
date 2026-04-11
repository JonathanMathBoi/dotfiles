{
  inputs,
  pkgs,
  ...
}:

{
  imports = [
    ./hardware-configuration.nix
    inputs.nixos-hardware.nixosModules.microsoft-surface-go
  ];

  hardware.microsoft-surface.kernelVersion = "stable";

  services.iptsd.enable = true;

  # Enabled for USB-C PD charging
  hardware.enableRedistributableFirmware = true;

  # TODO: Make surface-control work / make the various surface hardware accessable
  # Currently all uses of surface control just error
  environment.systemPackages = with pkgs; [
    surface-control
  ];
}
