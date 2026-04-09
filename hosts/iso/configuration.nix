{
  modulesPath,
  lib,
  pkgs,
  ...
}:

{
  imports = [
    "${modulesPath}/installer/cd-dvd/installation-cd-base.nix"
    ../../modules/system/common.nix
    ../../modules/system/networkmanager.nix
    ../../modules/system/pipewire.nix
    ../../modules/system/hyprland.nix
    ../../modules/system/sshd.nix
    ../../modules/system/udisks.nix
  ];

  nixpkgs.hostPlatform = "x86_64-linux";

  networking.hostName = "nixos";

  # Keep mutable users on live media so credentials can still be changed if needed.
  users.mutableUsers = lib.mkForce true;

  # Passwordless sudo for convenience on live/install media.
  security.sudo.wheelNeedsPassword = false;

  # Not useful on live/install media and can be noisy with transient devices.
  services.smartd.enable = lib.mkForce false;
  services.btrfs.autoScrub.enable = lib.mkForce false;

  # Auto-login directly into Hyprland via UWSM (no login screen)
  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "uwsm start hyprland-uwsm.desktop";
        user = "jonathan";
      };
    };
  };

  # Installation tools available on the ISO
  environment.systemPackages = with pkgs; [
    disko
    nixos-anywhere
    util-linux
  ];

  system.stateVersion = "25.11";
}
