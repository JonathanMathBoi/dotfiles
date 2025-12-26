{ config, ... }:

{
  imports = [
    ./hyprland.nix
    ./cursor.nix
    ./hyprlauncher.nix
    ./hypridle.nix
    ./hyprlock.nix

    # TODO: Switch from waybar to AGS
    ./waybar.nix
    ./dunst.nix

    ./alacritty.nix
    ./brave.nix
  ];
}
