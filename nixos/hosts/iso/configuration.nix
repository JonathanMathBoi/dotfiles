{ modulesPath, lib, ... }:

{
  imports = [
    "${modulesPath}/installer/cd-dvd/installation-cd-base.nix"
    ../../modules/system/common.nix
    ../../modules/system/networkmanager.nix
    ../../modules/system/pipewire.nix
    ../../modules/system/hyprland.nix
  ];

  nixpkgs.hostPlatform = "x86_64-linux";

  networking.hostName = "iso";

  # Override user settings from common.nix — no password file on the ISO
  users.mutableUsers = lib.mkForce true;
  users.users.jonathan.hashedPasswordFile = lib.mkForce null;
  users.users.jonathan.initialPassword = "iso";

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

  system.stateVersion = "25.11";
}
