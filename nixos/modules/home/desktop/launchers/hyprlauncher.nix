{ config, lib, ... }:

with lib;
let
  cfg = config.dots.desktop;
in
{
  config = mkIf (cfg.enable && cfg.launcher == "hyprlauncher") {
    services.hyprlauncher = {
      enable = true;
      settings = {
        finders = {
          desktop_launch_prefix = "env NIXOS_OZONE_WL=1 uwsm app -- ";
        };
      };
    };
  };
}
