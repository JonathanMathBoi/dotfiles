{ config, ... }:

{
  imports = [
    ./hyprland.nix
    ./cursor.nix
    ./hyprpaper.nix
    ./hyprlauncher.nix
    ./hypridle.nix
    ./hyprlock.nix
    ./mpris.nix

    # TODO: Switch from waybar to AGS
    ./waybar.nix
    ./dunst.nix

    ./alacritty.nix
    ./brave.nix
    ./discord.nix
  ];

  # Help with some apps to run in wayland rather then XWayland
  systemd.user.sessionVariables = {
    NIXOS_OZONE_WL = "1";
  };
}
