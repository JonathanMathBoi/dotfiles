{ config, pkgs, ... }:

{
  home.username = "jonathan";
  home.homeDirectory = "/home/jonathan";

  # This value determines the Home Manager release that the configuration is compatible with.
  home.stateVersion = "25.11"; 

  home.packages = [];

  programs.fish.enable = true;

  programs.starship = {
    enable = true;
    enableFishIntegration = true;
  };

  programs.zoxide = {
    enable = true;
    enableFishIntegration = true;
    options = [ "--cmd cd" ];
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
