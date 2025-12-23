{ config, pkgs, ... }:

{
  # This value determines the Home Manager release that the configuration is compatible with.
  home.stateVersion = "25.11";

  imports = [
    ../../modules/home/common.nix
  ];

  programs.git.signing.key = "8D216E5BA2708CD8";

  xdg.userDirs = {
    enable = true;
    createDirectories = true;

    desktop = "${config.home.homeDirectory}/desktop";
    documents = "${config.home.homeDirectory}/documents";
    download = "${config.home.homeDirectory}/downloads";
    music = "${config.home.homeDirectory}/music";
    pictures = "${config.home.homeDirectory}/pictures";
    videos = "${config.home.homeDirectory}/videos";
    publicShare = "${config.home.homeDirectory}/public";
    templates = "${config.home.homeDirectory}/templates";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
