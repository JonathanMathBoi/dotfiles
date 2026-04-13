{ config, ... }:

{
  sops.secrets."jungle/nut/upsmon-password" = { };

  power.ups = {
    enable = true;
    mode = "netserver";
    openFirewall = true;

    ups.apc = {
      driver = "usbhid-ups";
      port = "auto";
      description = "APC Back-UPS BE600M1";
      directives = [ "lowbatt = 25" ];
    };

    users.upsmon = {
      passwordFile = config.sops.secrets."jungle/nut/upsmon-password".path;
      upsmon = "primary";
    };

    upsmon.monitor.apc = {
      user = "upsmon";
      system = "apc@localhost";
      type = "primary";
    };

    upsd.listen = [
      {
        address = "0.0.0.0";
      }
      {
        address = "::";
      }
    ];
  };
}
