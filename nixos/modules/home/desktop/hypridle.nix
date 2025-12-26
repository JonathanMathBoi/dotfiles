{ ... }:

{
  services.hypridle = {
    enable = true;
    settings = {
      general = {
        lock_cmd = "pidof hyprlock || hyprlock";
        before_sleep_cmd = "loginctl lock-session";
        after_sleep_cmd = "hyprctl dispatch dpms on";
      };

      listener = [
        {
          # Lock screen after 3 min idle
          timeout = 3 * 60; # 3 * 1 minute
          on-timeout = "loginctl lock-session";
        }
        {
          # Turn off screen after 5 min idle
          timeout = 5 * 60; # 5 * 1 minute
          on-timeout = "hyprctl dispatch dpms off";
          on-resume = "hyprctl dispatch dpms on";
        }
      ];
    };
  };
}
