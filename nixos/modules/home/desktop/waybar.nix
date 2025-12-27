{ config, pkgs, ... }:

let
  # Manage the dependancies for the weather python script
  wttr-weather = pkgs.writers.writePython3Bin "wttr-weather" {
    libraries = [ pkgs.python3Packages.requests ];
  } (builtins.readFile ../../../../waybar/scripts/wttr.py);
in
{
  programs.waybar = {
    enable = true;
    systemd.enable = true;
  };

  home.packages = [ wttr-weather ];

  xdg.configFile."waybar".source =
    config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/waybar";
}
