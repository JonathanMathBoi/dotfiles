{ inputs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    inputs.nixos-hardware.nixosModules.framework-12-13th-gen-intel
  ];

  # Enabled for Intel iGPU firmware and related device firmware blobs.
  hardware.enableRedistributableFirmware = true;
}
