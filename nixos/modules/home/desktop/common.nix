{ config, ... }:

{
  imports = [
    ./hyprland.nix
    ./cursor.nix
    ./alacritty.nix

    # TODO: Switch from waybar to AGS
    ./waybar.nix
    ./dunst.nix
  ];
}
