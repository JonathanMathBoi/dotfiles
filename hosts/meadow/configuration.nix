{ ... }:

{
  imports = [
    ./persistence.nix
    ./surface-go-3
    ../../modules/system/systemd-boot.nix
    ../../modules/system/common.nix
    ../../modules/system/networkmanager.nix
    ../../modules/system/sshd.nix
    ../../modules/system/udisks.nix
    ../../modules/system/pipewire.nix
    ../../modules/system/bluetooth.nix
    ../../modules/system/hyprland.nix
    ../../modules/system/greetd.nix
    ../../modules/system/tailscale.nix
  ];

  networking.hostName = "meadow";

  # TODO: Add HRM and custom keyboard layout to mirror Lily58
  # Use Kanata

  hardware.ledger.enable = true;

  # Power management
  services.power-profiles-daemon.enable = true;
  # Disabled since power-profiles-daemon is the new standard way to deal with that
  services.tlp.enable = false;

  sops.age.sshKeyPaths = [ "/persist/etc/ssh/ssh_host_ed25519_key" ];

  # TODO: Configure remote building with forest

  # This option defines the first version of NixOS you have installed on this particular machine,
  # and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
  #
  # Most users should NEVER change this value after the initial install, for any reason,
  # even if you've upgraded your system to a new NixOS release.
  #
  # This value does NOT affect the Nixpkgs version your packages and OS are pulled from,
  # so changing it will NOT upgrade your system - see https://nixos.org/manual/nixos/stable/#sec-upgrading for how
  # to actually do that.
  #
  # This value being lower than the current NixOS release does NOT mean your system is
  # out of date, out of support, or vulnerable.
  #
  # Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
  # and migrated your data accordingly.
  #
  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "25.11"; # Did you read the comment?
}
