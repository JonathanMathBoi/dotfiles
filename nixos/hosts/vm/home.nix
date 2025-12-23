{ config, pkgs, ... }:

{
  # This value determines the Home Manager release that the configuration is compatible with.
  home.stateVersion = "25.11";

  imports = [
    ../../modules/home/common.nix
    ../../modules/home/user-dirs.nix
  ];

  programs.git.signing.key = "8D216E5BA2708CD8";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
