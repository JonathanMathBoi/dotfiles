{ ... }:

{
  home.username = "jonathan";
  home.homeDirectory = "/home/jonathan";
  home.language.base = "en_US.UTF-8";

  catppuccin = {
    flavor = "macchiato";
    enable = true;
  };

  imports = [
    ./shell.nix
    ./git.nix
    ./neovim.nix
    ./terminal-tools.nix
    ./tmux.nix
    ./fastfetch.nix
  ];
}
