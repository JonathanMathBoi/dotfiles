{ lib, config, ... }:

with lib;
let
  cfg = config.dots;
in
{
  imports = [
    ./shell.nix
    ./git.nix
    ./neovim.nix
    ./terminal-tools.nix
    ./tmux.nix
    ./fastfetch.nix

    ./desktop
  ];

  options.dots = {
    enable = mkEnableOption "dotfiles";
  };

  config = mkIf cfg.enable {
    home.username = "jonathan";
    home.homeDirectory = "/home/jonathan";
    home.language.base = "en_US.UTF-8";

    catppuccin = {
      flavor = "macchiato";
      enable = true;
    };
  };
}
