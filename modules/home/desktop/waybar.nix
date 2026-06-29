{ config, pkgs, ... }:

let
  # Manage the dependancies for the weather python script
  wttr-weather = pkgs.writers.writePython3Bin "wttr-weather" {
    libraries = [ pkgs.python3Packages.requests ];
  } (builtins.readFile ../../../waybar/scripts/wttr.py);
  waybar-countdown = pkgs.writers.writePython3Bin "waybar-countdown" { doCheck = false; } (
    builtins.readFile ../../../waybar/scripts/countdown.py
  );
in
{
  programs.waybar = {
    enable = true;
    systemd.enable = true;
  };

  home.packages = [
    wttr-weather
    waybar-countdown
  ];

  xdg.configFile."waybar".source =
    config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/waybar";

  # Disable Nix/Home Manager managed catppuccin theme for waybar since I already manage it myself
  catppuccin.waybar.enable = false;
}
