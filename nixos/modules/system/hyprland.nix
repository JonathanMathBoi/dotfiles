{ ... }:

{
  programs.hyprland = {
    enable = true;
    withUWSM = true;
  };

  # Ensure that all graphical apps close before hyprland closes
  # Needed to ensure Brave (and other chromium based apps) close cleanly at DE teardown
  systemd.user.services."wayland-wm@hyprland-uwsm.desktop" = {
    unitConfig = {
      Before = [ "graphical-session.target" ];
    };
  };
}
