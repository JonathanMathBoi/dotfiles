{ modulesPath, lib, pkgs, ... }:

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

  # Override user settings from common.nix — no password file or password on the ISO
  users.mutableUsers = lib.mkForce true;
  users.users.jonathan.hashedPasswordFile = lib.mkForce null;
  users.users.jonathan.hashedPassword = lib.mkForce "";

  # Passwordless sudo — no password is set, so it's required for usability
  security.sudo.wheelNeedsPassword = false;

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
