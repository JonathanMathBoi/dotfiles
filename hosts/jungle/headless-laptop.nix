{ lib, ... }:

{
  # Keep server behavior when the lid is closed.
  services.logind.settings.Login = {
    HandleLidSwitch = "ignore";
    HandleLidSwitchExternalPower = "ignore";
    HandleLidSwitchDocked = "ignore";
  };

  # Prevent sleep states on a headless always-on host.
  systemd.targets = {
    sleep.enable = false;
    suspend.enable = false;
    hibernate.enable = false;
    hybrid-sleep.enable = false;
  };

  # Ensure text-mode boot and blank Linux console after inactivity.
  systemd.defaultUnit = lib.mkDefault "multi-user.target";
  boot.kernelParams = [ "consoleblank=300" ];

  # Intel laptop thermal management.
  services.thermald.enable = true;
}
