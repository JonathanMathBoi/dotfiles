{ config, pkgs, ... }:

{
  # Ensure that all graphical apps close before hyprland closes
  # Needed to ensure Brave (and other chromium based apps) close cleanly at DE teardown
  systemd.user.services."wayland-wm@hyprland-uwsm.desktop" = {
    unitConfig = {
      Before = [ "graphical-session.target" ];
    };
  };

  xdg.configFile."hypr/hyprland.conf".source =
    config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/hypr/hyprland.conf";

  services.hyprpolkitagent.enable = true;

  home.packages = with pkgs; [
    wl-clipboard
    grimblast
  ];
}
