{ config, lib, ... }:

with lib;
let
  cfg = config.dots.desktop;
in
{
  config = mkIf (cfg.enable && cfg.hypridle.enable) {
    services.hypridle = {
      enable = true;
      settings = {
        general = {
          lock_cmd = "pidof hyprlock || uwsm app -- hyprlock";
          before_sleep_cmd = "loginctl lock-session";
          after_sleep_cmd = "hyprctl dispatch dpms on";
        };

        listener =
          if cfg.mobile then
            [
              {
                # Lock screen after 2 min idle on mobile
                timeout = 2 * 60;
                on-timeout = "loginctl lock-session";
              }
              {
                # Turn off screen after 3 min idle on mobile
                timeout = 3 * 60;
                on-timeout = "hyprctl dispatch dpms off";
                on-resume = "hyprctl dispatch dpms on";
              }
            ]
          else
            [
              {
                # Lock screen after 5 min idle on desktop
                timeout = 5 * 60;
                on-timeout = "loginctl lock-session";
              }
              {
                # Turn off screen after 10 min idle on desktop
                timeout = 10 * 60;
                on-timeout = "hyprctl dispatch dpms off";
                on-resume = "hyprctl dispatch dpms on";
              }
            ];
      };
    };
  };
}
