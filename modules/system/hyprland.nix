{ inputs, pkgs, ... }:

{
  programs.hyprland = {
    enable = true;
    withUWSM = true;

    # Use the development branch of hyprland
    package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
    portalPackage =
      inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
  };

  # Ensure that all graphical apps close before hyprland closes
  # Needed to ensure Brave (and other chromium based apps) close cleanly at DE teardown
  systemd.user.services."wayland-wm@hyprland-uwsm.desktop" = {
    unitConfig = {
      Before = [
        "graphical-session.target"
        "app-graphical.slice"
      ];
    };
  };
}
