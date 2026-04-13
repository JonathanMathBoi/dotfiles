{ inputs, pkgs, ... }:

{
  imports = [
    ./disko.nix
    ./hardware-configuration.nix
    inputs.nixos-hardware.nixosModules.framework-12-13th-gen-intel
  ];

  boot.kernelPackages = pkgs.linuxPackages_latest;

  # Enabled for Intel iGPU firmware and related device firmware blobs.
  hardware.enableRedistributableFirmware = true;
}
